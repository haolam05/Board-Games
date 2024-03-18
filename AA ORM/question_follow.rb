require_relative 'question'
require_relative 'user'
require_relative 'model_base'
require 'byebug'

class QuestionFollow < ModelBase
    attr_reader :id
    attr_accessor :user_id, :question_id

    def initialize(row)
        @id = row['id']
        @user_id = row['user_id']
        @question_id = row['question_id']
    end    

    def self.followers_for_question_id(question_id)
        # people who follows are: 1) author of question and 2) whoever replies to the question, the question written by author is the body of reply(=> author first reply is his question)
        followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                * 
            FROM
                users
            WHERE
                users.id IN (
                    SELECT
                        replies.author_id
                    FROM
                        questions
                    INNER JOIN replies
                        ON questions.id = replies.question_id
                    WHERE
                        replies.question_id = ?
                )
        SQL

        followers.map { |follower| User.new(follower) }
    end

    def self.followed_questions_for_user_id(user_id)
        # a user follows a question when: 1) he is the author of question or 2) he replies to a question
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                * 
            FROM
                questions
            WHERE
                questions.id IN (
                    SELECT
                        replies.question_id
                    FROM
                        users
                    INNER JOIN replies
                        ON users.id = replies.author_id
                    WHERE
                        replies.author_id = ?
                )
        SQL

        questions.map { |question| Question.new(question) }
    end

    def self.most_followed_questions(n) #n: number of most followed question we want to show
        #followers of a question are repliers to that question, (including author of question-also a replier)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT 
                *, COUNT(question_id) AS 'followers' 
            FROM 
                questions 
            INNER JOIN replies 
                ON questions.id = replies.question_id 
            GROUP BY 
                question_id 
            ORDER BY 
                followers DESC 
            LIMIT   
                ?
        SQL
        
        questions.map { |question| Question.new(question) }
    end

end

if __FILE__ == $PROGRAM_NAME
    puts "---\n"
    
    question_follows = QuestionFollow.all
    question_follows.each { |question_follow| p question_follow } 

    puts "\n---\n\n"

    p QuestionFollow.followers_for_question_id(3)

    puts "\n---\n\n"

    p QuestionFollow.followed_questions_for_user_id(1)
    p QuestionFollow.followed_questions_for_user_id(2)

    puts "\n---\n\n"

    p QuestionFollow.most_followed_questions(2)
    p QuestionFollow.most_followed_questions(1)
end