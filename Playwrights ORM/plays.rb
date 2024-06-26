require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all  #[ {}, {}, {}, ... ]
    plays = PlayDBConnection.instance.execute("SELECT * FROM plays")
    plays.map { |play| Play.new(play) }
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
                                                  #[ {} ]
    play.empty? ? "title not found!" : Play.new(play.first)
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name) #finds playwright row(instance) that has this name

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT  
        *
      FROM
        plays
      WHERE 
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @year = options["year"]
    @playwright_id = options["playwright_id"]
  end

  def create
    raise "#{self} already in database!" if id

    PlayDBConnection.instance.execute(<<-SQL, title, year, playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not found!" if id.nil?
    
    PlayDBConnection.instance.execute(<<-SQL, title, year, playwright_id, id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  attr_accessor :id, :name, :birth_year

  def self.all
    playwrights = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    playwrights.map { |playwright| Playwright.new(playwright) }
  end

  def self.find_by_name(name)
    playwright = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM 
        playwrights
      WHERE
        name = ?
    SQL

    playwright.empty? ? "name not found!" : Playwright.new(playwright.first)
  end
  
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @birth_year = options["birth_year"]
  end

  def create
    raise "#{self} already in database!" if id

    PlayDBConnection.instance.execute(<<-SQL, name, birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not found!" if id.nil?
    
    PlayDBConnection.instance.execute(<<-SQL, name, birth_year, id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    Play.find_by_playwright(name)
  end
end

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# class Play
#   attr_accessor :id, :title, :year, :playwright_id
  
#   def self.all
#     data = PlayDBConnection.instance.execute("SELECT * FROM plays")
#     data.map { |datum| Play.new(datum) }  #fata = [{}, {}, {}, {}, ...]
#   end

#   def self.find_by_title(title)
#     play = PlayDBConnection.instance.execute(<<-SQL, title)
#       SELECT 
#         *
#       FROM
#         plays
#       WHERE
#         title = ?
#     SQL

#     play.empty? ? nil : Play.new(play.first)  #play = [{}]
#   end

#   def self.find_by_play_wright(name)
#     play_wright = Playwright.find_by_name(name)

#     plays = PlayDBConnection.instance.execute(<<-SQL, play_wright.id)
#       SELECT 
#         *
#       FROM
#         plays
#       WHERE
#         playwright_id = ?
#     SQL

#     plays.map { |play| Play.new(play) }
#   end

#   def initialize(options)
#     @id = options['id']
#     @title = options['title']
#     @year = options['year']
#     @playwright_id = options['playwright_id']
#   end

#   def create
#     raise "#{self} already in database" if self.id

#     PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
#       INSERT INTO
#         plays (title, year, playwright_id)
#       VALUES
#         (?, ?, ?)
#     SQL

#     self.id = PlayDBConnection.instance.last_insert_row_id
#   end

#   def update
#     raise "#{self} not in database" unless self.id

#     PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
#       UPDATE
#         plays
#       SET
#         title = ?, year = ?, playwright_id = ?
#       WHERE
#         id = ?
#     SQL
#   end
# end

# class Playwright
#   attr_accessor :id, :name, :birth_year

#   def self.all
#     data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
#     data.map { |datum| Playwright.new(datum) }
#   end

#   def self.find_by_name(name)
#     person = PlayDBConnection.instance.execute(<<-SQL, name)
#       SELECT 
#         *
#       FROM
#         playwrights
#       WHERE
#         name = ?
#     SQL

#     person.empty? ? "Not found in Database" : Playwright.new(person.first)
#   end
  
#   def initialize(options)
#     @name = options['name']
#     @id = options['id']
#     @birth_year = options['birth_year']
#   end

#   def create
#     raise "#{self} already in database" if self.id

#     PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
#       INSERT INTO
#         playwrights (name, birth_year)
#       VALUES
#         (?, ?)
#     SQL

#     self.id = PlayDBConnection.instance.last_insert_row_id
#   end

#   def update
#     raise "#{self} not in database" unless self.id

#     PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
#       UPDATE
#         playwrights
#       SET
#         name = ?, birth_year = ?
#       WHERE
#         id = ?
#     SQL
#   end

#   def get_plays
#     Play.find_by_play_wright(self.name)
#   end
# end