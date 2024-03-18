require_relative 'model_base'
require_relative 'user'
require_relative 'question'

class QuestionLike < ModelBase
    attr_reader :id
    attr_accessor :user_id, :question_id

    def initialize(row)
        @id = row['id']
        @user_id = row['user_id']
        @question_id = row['question_id']
    end  

    def self.likers_for_question_id(question_id)
        likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                question_likes
            INNER JOIN users
                ON users.id = question_likes.user_id
            WHERE
                question_id = ?
        SQL
        
        likers.map { |liker| User.new(liker) }
    end

    def self.num_likes_for_question_id(question_id)
        QuestionsDatabase.instance.get_first_value(<<-SQL, question_id)
            SELECT
                COUNT(*) AS 'likes'
            FROM
                question_likes
            WHERE
                question_id = ?
        SQL
    end

    def self.liked_questions_for_user_id(user_id)
        # needs to get qustion object => join with questions table to get all info for Question.new(question)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                question_likes
            INNER JOIN questions
                ON questions.id = question_likes.question_id
            WHERE 
                user_id = ?
        SQL

        questions.map { |question| Question.new(question) }
    end
    
    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                *
            FROM
                question_likes
            INNER JOIN questions
                ON questions.id = question_likes.question_id
            GROUP BY
                question_id 
            ORDER BY
                COUNT(*) DESC
            LIMIT
                ?
        SQL
        
        questions.map { |question| Question.new(question) }
    end
end

if __FILE__ == $PROGRAM_NAME
    question_likes = QuestionLike.all
    question_likes.each { |question_like| p question_like }
    
    puts '--------------000--------------'

    p QuestionLike.likers_for_question_id(3)

    puts '--------------000--------------'

    p QuestionLike.num_likes_for_question_id(1)
    p QuestionLike.num_likes_for_question_id(2)
    p QuestionLike.num_likes_for_question_id(3)

    puts '--------------000--------------'

    p QuestionLike.liked_questions_for_user_id(1)
    p QuestionLike.liked_questions_for_user_id(2)
    p QuestionLike.liked_questions_for_user_id(3)

    puts '--------------000--------------'
    p QuestionLike.most_liked_questions(3)
    p QuestionLike.most_liked_questions(2)
    p QuestionLike.most_liked_questions(1)

    puts '--------------000--------------'

end