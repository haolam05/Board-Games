require 'singleton'
require 'sqlite3'

# handles connection to database
class QuestionsDatabase < SQLite3::Database 

    #only allows class methods
    include Singleton   

    SQL_FILE_NAME = 'import_db.sql'
    DB_NAME = 'questions.db'

    def self.instance
        import_db_from_sql_file! if @database.nil?
        @database
    end

    def self.import_db_from_sql_file!
        `#{"cat #{SQL_FILE_NAME} | sqlite3 #{DB_NAME}"}`
        open
    end

    def self.open
        @database = SQLite3::Database.new(DB_NAME)
        @database.type_translation = true
        @database.results_as_hash = true
    end
end

# a = File.dirname(__FILE__);
# b = File.join(a, 'import_db.sql');
# p a
# p b 

# d = QuestionsDatabase.instance
# p d