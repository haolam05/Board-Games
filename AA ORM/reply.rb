require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class Reply < ModelBase
    attr_reader :id
    attr_accessor :question_id, :parent_reply_id, :author_id, :body

    def initialize(row)
        @id = row['id']
        @question_id = row['question_id']
        @parent_reply_id = row['parent_reply_id']
        @author_id = row['author_id']
        @body = row['body']
    end  

    def self.find_by_user_id(user_id)
        Reply.find_by("author_id" => user_id)
    end

    def self.find_by_question_id(question_id)
        Reply.find_by("question_id" => question_id)
    end

    def author
        User.find_by_id(author_id)
    end

    def question
        Question.find_by_id(question_id)
    end

    def child_replies
        Reply.find_by("parent_reply_id" => id)
    end

    def save
        id.nil? ? self.create : self.update
    end
end


if __FILE__ == $PROGRAM_NAME
    replies = Reply.all
    
    p Reply.find_by_question_id(3)
    puts '----'

    p Reply.find_by_user_id(1)
    p Reply.find_by_user_id(2)
    puts '----'

    p replies.first.author
    p replies[1].author
    puts '----'

    p replies[0].question
    p replies[1].question
    puts '----'

    p replies.first.child_replies
    puts '----'
end