require_relative 'question_follow'
require_relative 'question'
require_relative 'reply'
require_relative 'model_base'

class User < ModelBase
    attr_reader :id
    attr_accessor :fname, :lname

    def initialize(row)
        @id = row['id']
        @fname = row['fname']
        @lname = row['lname']
    end  

    def self.find_by_name(fname, lname)
        User.find_by("fname" => fname, "lname" => lname)
    end

    def author_questions
        Question.find_by_author_id(id)
    end

    def author_replies
        Reply.find_by_user_id(id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(id)
    end

    def save
        id.nil? ? self.create : self.update
    end

    def average_karma
        # means: number of likes on those questions / numbers of question asked by user
        # number of likes     : count question_likes.id => count non-null row, null means question is not being liked
        # number of questions : a question that is liked multiple times will be repeated in the joined table => count distinct on questions.id (it includes null on question_likes.question_id if question is not liked)
        # finally, cast one of the count as float: CAST(value AS FLOAT)
        QuestionsDatabase.instance.get_first_value(<<-SQL, id)
            SELECT 
                CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id)) AS 'average_karma'
            FROM
                questions
            LEFT OUTER JOIN question_likes 
                ON question_likes.question_id = questions.id
            WHERE
                questions.author_id = ?
        SQL
    end
end

puts __FILE__
puts $PROGRAM_NAME
puts

if __FILE__ == $PROGRAM_NAME
    user = User.new('fname' => 'Hao', 'lname' => 'Lam')
    # user.create
    user.save

    p User.find_by_name('Ned', 'Ruggeri')

    puts '--------------000--------------'

    users = User.all
    users.each { |user| p user }

    puts '--------------000--------------'

    user.fname = 'Cat'
    user.save

    users = User.all
    users.each { |user| p user }
    p users.first.author_questions

    puts '--------------000--------------'

    replies = Reply.all
    replies.each { |reply| p reply }

    p users.first.author_replies
    p users[1].author_replies

    puts '--------------000--------------'

    p users.first.followed_questions
    p users[1].followed_questions
    p users[2].followed_questions

    puts '--------------000--------------'
    p users[0].liked_questions
    p users[1].liked_questions
    p users[2].liked_questions

    puts '--------------000--------------'
    p users[0].average_karma
    p users[1].average_karma
    p users[2].average_karma

    puts '--------------000--------------'
end