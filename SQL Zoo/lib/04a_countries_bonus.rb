# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
         countries
        WHERE
          continent = 'Europe' 
        GROUP BY
          continent
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      a.continent, (
        SELECT
          b.name
        FROM
          countries b
        WHERE
          a.continent = b.continent AND b.area = MAX(a.area)
      ), MAX(a.area)
    FROM
      countries a
    GROUP BY
      a.continent
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      a.name, a.continent
    FROM
      countries a
    WHERE
      a.population > 3 * (
        SELECT
          MAX(b.population)
        FROM
          countries b
        WHERE
          a.continent = b.continent AND a.name != b.name
        GROUP BY
          continent
      )
  SQL
end

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# # == Schema Information
# #
# # Table name: countries
# #
# #  name        :string       not null, primary key
# #  continent   :string
# #  area        :integer
# #  population  :integer
# #  gdp         :integer

# require_relative './sqlzoo.rb'

# def highest_gdp
#   # Which countries have a GDP greater than every country in Europe? (Give the
#   # name only. Some countries may have NULL gdp values)
#   execute(<<-SQL)
#     SELECT
#       name
#     FROM
#       countries
#     WHERE
#       gdp > (
#         SELECT
#           MAX(gdp)
#         FROM
#           countries
#         WHERE
#           continent = 'Europe'
#       )
#   SQL
# end

# def largest_in_continent
#   # Find the largest country (by area) in each continent. Show the continent,
#   # name, and area.
#   execute(<<-SQL)
#     SELECT 
#       continent, name, area
#     FROM
#       countries
#     WHERE
#       area IN (
#         SELECT
#           MAX(area)
#         FROM
#           countries
#         GROUP BY 
#           continent
#       )
#   SQL
# end

# def large_neighbors
#   # Some countries have populations more than three times that of any of their
#   # neighbors (in the same continent). Give the countries and continents.
#   execute(<<-SQL)
#     SELECT
#       a.name, a.continent
#     FROM
#       countries a
#     WHERE
#       population > 3 * ( 
#         SELECT 
#           MAX(population)
#         FROM
#           countries b
#         WHERE
#           a.continent = b.continent AND a.name != b.name
#         GROUP BY
#           b.continent
#       )  
#   SQL
# end
