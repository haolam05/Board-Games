# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_joinb
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      title
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      title
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      name = 'Harrison Ford' AND ord != 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT DISTINCT
      title, name
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      yr = 1962 AND ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      yr, COUNT(title)
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      name = 'John Travolta'
    GROUP BY 
      yr
    HAVING 
      COUNT(title) >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      title, (
        SELECT DISTINCT
          name
        FROM
          movies b
        INNER JOIN castings 
          ON b.id = castings.movie_id
        INNER JOIN actors 
          ON actors.id = castings.actor_id
        WHERE
          ord = 1 AND b.id = movies.id
      )
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      name = 'Julie Andrews'
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      name
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      ord = 1
    GROUP BY
      name
    HAVING
      COUNT(ord) >= 15
    ORDER BY
      name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT 
      title, COUNT(name)
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      yr = 1978
    GROUP BY
      title
    ORDER BY
      COUNT(name) DESC, title ASC
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      movies
    INNER JOIN castings 
      ON movies.id = castings.movie_id
    INNER JOIN actors 
      ON actors.id = castings.actor_id
    WHERE
      name != 'Art Garfunkel' AND title IN (
        SELECT
          title
        FROM
          movies
        INNER JOIN castings 
          ON movies.id = castings.movie_id
        INNER JOIN actors 
          ON actors.id = castings.actor_id
        WHERE
          name = 'Art Garfunkel' 
      )
  SQL
end

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# # == Schema Information
# #
# # Table name: actors
# #
# #  id          :integer      not null, primary key
# #  name        :string
# #
# # Table name: movies
# #
# #  id          :integer      not null, primary key
# #  title       :string
# #  yr          :integer
# #  score       :float
# #  votes       :integer
# #  director_id :integer
# #
# # Table name: castings
# #
# #  movie_id    :integer      not null, primary key
# #  actor_id    :integer      not null, primary key
# #  ord         :integer

# require_relative './sqlzoo.rb'

# def example_join
#   execute(<<-SQL)
#     SELECT
#       *
#     FROM
#       movies
#     JOIN
#       castings ON movies.id = castings.movie_id
#     JOIN
#       actors ON castings.actor_id = actors.id
#     WHERE
#       actors.name = 'Sean Connery'
#   SQL
# end

# def ford_films
#   # List the films in which 'Harrison Ford' has appeared.
#   execute(<<-SQL)
#     SELECT
#       title
#     FROM 
#       movies
#     INNER JOIN castings
#       ON castings.movie_id = movies.id
#     INNER JOIN actors
#       ON castings.actor_id = actors.id
#     WHERE
#       name = 'Harrison Ford'
#   SQL
# end

# def ford_supporting_films
#   # List the films where 'Harrison Ford' has appeared - but not in the star
#   # role. [Note: the ord field of casting gives the position of the actor. If
#   # ord=1 then this actor is in the starring role]
#   execute(<<-SQL)
#     SELECT
#       title
#     FROM 
#       movies
#     INNER JOIN castings
#       ON castings.movie_id = movies.id
#     INNER JOIN actors
#       ON castings.actor_id = actors.id
#     WHERE
#       name = 'Harrison Ford' AND ord != 1
#   SQL
# end

# def films_and_stars_from_sixty_two
#   # List the title and leading star of every 1962 film.
#   execute(<<-SQL)
#     SELECT
#       title, name
#     FROM 
#       movies
#     INNER JOIN castings
#       ON castings.movie_id = movies.id
#     INNER JOIN actors
#       ON castings.actor_id = actors.id
#     WHERE
#       yr = 1962 AND ord = 1
#   SQL
# end

# def travoltas_busiest_years
#   # Which were the busiest years for 'John Travolta'? Show the year and the
#   # number of movies he made for any year in which he made at least 2 movies.
#   execute(<<-SQL)
#     SELECT
#       yr, COUNT(title)
#     FROM 
#       actors
#     INNER JOIN castings
#       ON actors.id = castings.actor_id
#     INNER JOIN movies
#       ON movies.id = castings.movie_id
#     WHERE
#       name = 'John Travolta'
#     GROUP BY
#       yr
#     HAVING
#       COUNT(title) >= 2
#   SQL
# end

# def andrews_films_and_leads
#   # List the film title and the leading actor for all of the films 'Julie
#   # Andrews' played in.
#   execute(<<-SQL)
#     SELECT
#       movies.title, lead_actors.name
#     FROM 
#       movies
#     INNER JOIN castings AS "julie_andrews_castings"
#       ON movies.id = julie_andrews_castings.movie_id
#     INNER JOIN actors AS "julie_andrews_actors"
#       ON julie_andrews_actors.id = julie_andrews_castings.actor_id
#     INNER JOIN castings AS "lead_castings"
#       ON movies.id = lead_castings.movie_id
#     INNER JOIN actors AS "lead_actors"
#       ON lead_actors.id = lead_castings.actor_id
#     WHERE
#       julie_andrews_actors.name = 'Julie Andrews' AND lead_castings.ord = 1
#   SQL
# end
#   #FIRST 2 JOINS: find movies where julie andrews played in
#   #LAST 2 JOINS : find the leading actors of these movies

#   # execute(<<-SQL)
#   #   SELECT
#   #     title, (
#   #       SELECT
#   #         name
#   #       FROM actors
#   #       INNER JOIN castings
#   #         ON actors.id = castings.actor_id
#   #       INNER JOIN movies a
#   #         ON a.id = castings.movie_id
#   #       WHERE
#   #         ord = 1 AND a.id = movies.id
#   #     )
#   #   FROM 
#   #     actors
#   #   INNER JOIN castings
#   #     ON actors.id = castings.actor_id
#   #   INNER JOIN movies 
#   #     ON movies.id = castings.movie_id
#   #   WHERE
#   #     name = 'Julie Andrews' 
#   # SQL

# def prolific_actors
#   # Obtain a list in alphabetical order of actors who've had at least 15
#   # starring roles.
#   execute(<<-SQL)
#     SELECT
#       name
#     FROM
#       actors
#     INNER JOIN castings
#       ON castings.actor_id = actors.id
#     WHERE
#       ord = 1
#     GROUP BY
#       name
#     HAVING
#       COUNT(movie_id) >= 15
#     ORDER BY
#       name ASC
#   SQL
# end

# def films_by_cast_size
#   # List the films released in the year 1978 ordered by the number of actors
#   # in the cast (descending), then by title (ascending).
#   execute(<<-SQL)
#     SELECT 
#       title, COUNT(actor_id) 
#     FROM
#       movies
#     INNER JOIN castings
#       ON castings.movie_id = movies.id
#     WHERE
#       yr = 1978
#     GROUP BY
#       title
#     ORDER BY 
#       COUNT(actor_id) DESC, title ASC
#   SQL
# end

# def colleagues_of_garfunkel
#   # List all the people who have played alongside 'Art Garfunkel'.
#   execute(<<-SQL)
#     SELECT
#       name
#     FROM
#       movies
#     INNER JOIN castings
#       ON castings.movie_id = movies.id
#     INNER JOIN actors
#       ON castings.actor_id = actors.id   
#     WHERE
#       title IN (
#         SELECT 
#           title
#         FROM 
#           movies
#         INNER JOIN castings
#           ON castings.movie_id = movies.id
#         INNER JOIN actors
#           ON castings.actor_id = actors.id
#         WHERE
#           actors.name = 'Art Garfunkel'
#       ) AND name != 'Art Garfunkel'
#   SQL
# end