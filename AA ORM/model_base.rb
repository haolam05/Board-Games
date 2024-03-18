require 'active_support/inflector'
require_relative 'questions_database'


class ModelBase                                             #instance methhod: self == @datbase
    def self.all                                            #classs method   : self == Question
        result = QuestionsDatabase.instance.execute(<<-SQL) 
            SELECT
                *
            FROM   
                #{table}
        SQL

        result.map { |row| self.new(row) }
    end

    def self.table
        self.to_s.tableize
    end

    def self.find_by_id(id)
        result = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT 
                *
            FROM
                #{table}
            WHERE
                id = ?
        SQL

        result.empty? ? nil : self.new(result.first)
    end #result = [{}]

    def self.find_by(params)
        # Hash input   : (lname => "Oberyn", fname: "Martell")
        # String input : ("title LIKE '%Who%' AND title LIKE '%Arstan Whitebeard%'")
        if params.is_a?(Hash)
            where_line = params.keys.map { |key| key + ' = ? ' }.join(' AND ')
            values = params.values
        elsif params.is_a?(String)
            where_line = params
            values = []
        end

        result = QuestionsDatabase.instance.execute(<<-SQL, *values)
            SELECT
                *
            FROM
                #{table}
            WHERE
                #{where_line}
        SQL
        
        result.map { |row| self.new(row) }
    end

    def create
        raise "#{self} already in database!" if id

        QuestionsDatabase.instance.execute(<<-SQL, *get_instance_variables_values)
            INSERT INTO 
                #{self.class.table} (#{get_instance_variables})
            VALUES 
                (#{get_question_marks})
        SQL
        
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update 
        raise "#{self} not found!" if id.nil?

        QuestionsDatabase.instance.execute(<<-SQL, *get_instance_variables_values, id)
            UPDATE
                #{self.class.table}
            SET
                #{get_instance_variables(true)}
            WHERE
                id = ?
        SQL
    end
private
    def get_instance_variables_values
        self.instance_variables[1..-1].map { |attribute| self.instance_variable_get(attribute) }
    end
    
    def get_instance_variables(set_line = false)    #all column names except id col
        attrs = self.instance_variables[1..-1].map { |attribute| attribute[1..-1] }
        attrs = attrs.map { |attr| attr + ' = ?' } if set_line
        attrs.join(', ')
    end # :@attribute => @attribute => attribute

    def get_question_marks
        (['?'] * self.instance_variables[1..-1].length).join(', ')
    end
end