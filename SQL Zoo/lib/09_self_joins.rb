# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(stops.*)
    FROM
      stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT
      id
    FROM
      stops
    WHERE
      name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      id, name
    FROM
      stops
    INNER JOIN routes   
      ON routes.stop_id = stops.id
    WHERE
      num = '4' AND company = 'LRT'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
    SELECT
        company,
        num,
        COUNT(*)
      FROM
        routes
      WHERE
        stop_id = 149 OR stop_id = 53
      GROUP BY
        company, num
      HAVING COUNT(*) = 2
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      a.stop_id,
      b.stop_id
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    WHERE
      a.stop_id = 53 AND b.stop_id = '149'
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      stopa.name,
      stopb.name
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart' AND stopb.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT DISTINCT
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    WHERE
      a.stop_id = 115 AND b.stop_id = 137
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE 
      stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT
      stopb.name,
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart'
  SQL
end


def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    SELECT DISTINCT
      start.num, start.company, transferring_point.name, "end".num, "end".company
    FROM
      routes start
    JOIN
      routes to_transfer ON start.company = to_transfer.company AND start.num = to_transfer.num
    JOIN
      routes from_transfer ON (to_transfer.stop_id = from_transfer.stop_id)
    JOIN
      routes "end" ON (from_transfer.company = "end".company AND from_transfer.num = "end".num)
    JOIN
      stops starting_point ON start.stop_id = starting_point.id
    JOIN
      stops transferring_point ON to_transfer.stop_id = transferring_point.id
    JOIN
      stops ending_point ON "end".stop_id = ending_point.id
    WHERE
      starting_point.name = 'Craiglockhart' AND ending_point.name = 'Sighthill'
  SQL
end

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# # == Schema Information
# #
# # Table name: stops
# #
# #  id          :integer      not null, primary key
# #  name        :string
# #
# # Table name: routes
# #
# #  num         :string       not null, primary key
# #  company     :string       not null, primary key
# #  pos         :integer      not null, primary key
# #  stop_id     :integer

# require_relative './sqlzoo.rb'

# def num_stops
#   # How many stops are in the database?
#   execute(<<-SQL)
#     SELECT 
#       COUNT(DISTINCT stops.*)
#     FROM
#       stops
#     INNER JOIN routes
#       ON routes.stop_id = stops.id
#   SQL
# end

# def craiglockhart_id
#   # Find the id value for the stop 'Craiglockhart'.
#   execute(<<-SQL)
#     SELECT
#       id
#     FROM 
#       stops
#     WHERE   name = 'Craiglockhart'
#   SQL
# end

# def lrt_stops
#   # Give the id and the name for the stops on the '4' 'LRT' service.
#   execute(<<-SQL)
#     SELECT
#       id, name
#     FROM 
#       stops
#     INNER JOIN routes
#       ON routes.stop_id = stops.id
#     WHERE
#       num = '4' AND company = 'LRT'
#   SQL
# end

# def connecting_routes
#   # Consider the following query:
#   #
#   # SELECT
#   #   company,
#   #   num,
#   #   COUNT(*)
#   # FROM
#   #   routes
#   # WHERE
#   #   stop_id = 149 OR stop_id = 53
#   # GROUP BY
#   #   company, num
#   #
#   # The query gives the number of routes that visit either London Road
#   # (149) or Craiglockhart (53). Run the query and notice the two services
#   # that link these stops have a count of 2. Add a HAVING clause to restrict
#   # the output to these two routes.
#   execute(<<-SQL)
#   SELECT
#     company,
#     num,
#     COUNT(*)
#   FROM
#     routes
#   WHERE
#     stop_id = 149 OR stop_id = 53
#   GROUP BY
#     company, num
#   HAVING
#     COUNT(*) = 2
#   SQL
# end

# def cl_to_lr
#   # Consider the query:
#   #
#   # SELECT
#   #   a.company,
#   #   a.num,
#   #   a.stop_id,
#   #   b.stop_id
#   # FROM
#   #   routes a
#   # JOIN
#   #   routes b ON (a.company = b.company AND a.num = b.num)
#   # WHERE
#   #   a.stop_id = 53
#   #
#   # Observe that b.stop_id gives all the places you can get to from
#   # Craiglockhart, without changing routes. Change the query so that it
#   # shows the services from Craiglockhart to London Road.
#   execute(<<-SQL)
#     SELECT
#       a.company,
#       a.num,
#       a.stop_id,
#       b.stop_id
#     FROM
#       routes a
#     JOIN
#       routes b ON (a.company = b.company AND a.num = b.num)
#     WHERE
#       a.stop_id = 53 AND b.stop_id = 149
#   SQL
# end

# def cl_to_lr_by_name
#   # Consider the query:
#   #
#   # SELECT
#   #   a.company,
#   #   a.num,
#   #   stopa.name,
#   #   stopb.name
#   # FROM
#   #   routes a
#   # JOIN
#   #   routes b ON (a.company = b.company AND a.num = b.num)
#   # JOIN
#   #   stops stopa ON (a.stop_id = stopa.id)
#   # JOIN
#   #   stops stopb ON (b.stop_id = stopb.id)
#   # WHERE
#   #   stopa.name = 'Craiglockhart'
#   #
#   # The query shown is similar to the previous one, however by joining two
#   # copies of the stops table we can refer to stops by name rather than by
#   # number. Change the query so that the services between 'Craiglockhart' and
#   # 'London Road' are shown.
#   execute(<<-SQL)
#   SELECT
#     a.company,
#     a.num,
#     stopa.name,
#     stopb.name
#   FROM
#     routes a
#   JOIN
#     routes b ON (a.company = b.company AND a.num = b.num)
#   JOIN
#     stops stopa ON (a.stop_id = stopa.id)
#   JOIN
#     stops stopb ON (b.stop_id = stopb.id)
#   WHERE
#     stopa.name = 'Craiglockhart' AND stopb.name = 'London Road'
#   SQL
# end

# def haymarket_and_leith
#   # Give the company and num of the services that connect stops
#   # 115 and 137 ('Haymarket' and 'Leith')
#   execute(<<-SQL)
#     SELECT DISTINCT
#       a.company, a.num
#     FROM 
#       routes a
#     INNER JOIN routes b
#       ON (a.company = b.company AND a.num = b.num) 
#     WHERE
#       a.stop_id = 115 AND b.stop_id = 137
#   SQL
# end

# def craiglockhart_and_tollcross
#   # Give the company and num of the services that connect stops
#   # 'Craiglockhart' and 'Tollcross'
#   execute(<<-SQL)
#     SELECT 
#       a.company, a.num
#     FROM 
#       routes a
#     INNER JOIN routes b
#       ON (a.company = b.company AND a.num = b.num) 
#     INNER JOIN stops stop_a
#       ON stop_a.id = a.stop_id
#     INNER JOIN stops stop_b
#       ON stop_b.id = b.stop_id
#     WHERE
#         stop_a.name = 'Craiglockhart' AND stop_b.name = 'Tollcross'
#   SQL
# end

# def start_at_craiglockhart
#   # Give a distinct list of the stops that can be reached from 'Craiglockhart'
#   # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
#   # as well as the company and bus no. of the relevant service.
#   execute(<<-SQL)
#     SELECT
#       stop_b.name, a.company, a.num
#     FROM
#       routes a
#     INNER JOIN routes b
#       ON (a.company = b.company AND a.num = b.num)
#     INNER JOIN stops stop_a
#       ON stop_a.id = a.stop_id
#     INNER JOIN stops stop_b
#       ON stop_b.id = b.stop_id
#     WHERE 
#       stop_a.name = 'Craiglockhart'
#   SQL
# end

# def craiglockhart_to_sighthill
#   # Find the routes involving two buses that can go from Craiglockhart to
#   # Sighthill. Show the bus no. and company for the first bus, the name of the
#   # stop for the transfer, and the bus no. and company for the second bus.
#   execute(<<-SQL)
#     SELECT DISTINCT
#       start.num, start.company, transfering_point.name, finish.num, finish.company
#     FROM
#       routes start
#     INNER JOIN routes to_transfer
#       ON start.company = to_transfer.company AND start.num = to_transfer.num
#     INNER JOIN routes from_transfer
#       ON from_transfer.stop_id = to_transfer.stop_id
#     INNER JOIN routes finish
#       ON finish.company = from_transfer.company AND finish.num = from_transfer.num
#     INNER JOIN stops starting_point
#       ON starting_point.id = start.stop_id
#     INNER JOIN stops transfering_point
#       ON transfering_point.id = to_transfer.stop_id
#     INNER JOIN stops finishing_point
#       ON finishing_point.id = finish.stop_id
#     WHERE
#       starting_point.name = 'Craiglockhart' AND finishing_point.name = 'Sighthill' 
#   SQL
# end