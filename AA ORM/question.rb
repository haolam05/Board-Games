require_relative 'question_like'
require_relative 'question_follow'
require_relative 'user'
require_relative 'reply'
require_relative 'model_base'

class Question < ModelBase
    attr_reader :id
    attr_accessor :title, :body, :author_id

    def initialize(row)
        @id = row['id']
        @title = row['title']
        @body = row['body']
        @author_id = row['author_id']
    end

    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end

    def self.most_followed(n) #n: number of most followed question we want to show
        QuestionFollow.most_followed_questions(n)
    end
    
    def self.find_by_author_id(author_id)
        Question.find_by("author_id" => author_id)
    end

    def author
        User.find_by_id(author_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        QuestionFollow.followers_for_question_id(id)
    end
    
    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

    def save
        id.nil? ? self.create : self.update
    end
end

puts __FILE__
puts $PROGRAM_NAME
puts

if __FILE__ == $PROGRAM_NAME
    q1 = Question.new("title" => "TITLE", "body" => "what is the title?", "author_id" => 4)
    q2 = Question.new("title" => "TITLE", "body" => "what is the title?", "author_id" => 4)

    questions = Question.all
    questions.each { |question| p question }
    # p q1.id

    puts '--------------000--------------'

    q1.save
    questions = Question.all
    questions.each { |question| p question }

    puts '--------------000--------------'

    q1.title = "title"
    # p q1.title
    # p q1.id
    questions = Question.all
    questions.each { |question| p question }

    q1.save

    puts
    # q2.create
    # p q2.id

    questions = Question.all
    questions.each { |question| p question }

    puts '--------------000--------------'

    p Question.find_by_id(4)
    p Question.find_by_id(8)

    p Question.find_by("title" => "TITLE", "author_id" => 4)
    puts '--------------000--------------'

    p Question.find_by("author_id" => 4)
    puts '--------------000--------------'

    p Question.find_by_author_id(4)
    puts '--------------000--------------'

    p Question.all[0].author

    users = User.all
    users.each { |user| p user }

    p questions[2].replies

    replies = Reply.all
    replies.each { |reply| p reply }
    puts '--------------000--------------'

    p questions[2].followers
    p questions[1].followers

    puts '--------------000--------------'
    p Question.most_followed(2)
    p Question.most_followed(1)

    puts '--------------000--------------'
    p questions[0].likers
    p questions[1].likers
    p questions[2].likers

    puts '--------------000--------------'
    p questions[1].num_likes
    p questions[0].num_likes
    p questions[2].num_likes

    puts '--------------000--------------'
    p Question.most_liked_questions(3)
    p Question.most_liked_questions(2)
    p Question.most_liked_questions(1)
end