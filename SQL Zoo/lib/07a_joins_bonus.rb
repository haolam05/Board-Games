# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

#"Track" means "song"
#"title" is album's name
#tracks.album represents which album the song belongs to. Many song can belong to the same album
#albums.asin is the distinct representation value for each album

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT
      artist
    FROM
      albums
    INNER JOIN tracks
      ON tracks.album = albums.asin
    WHERE
      song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT
      artist
    FROM
      albums
    INNER JOIN tracks
      ON tracks.album = albums.asin
    WHERE
      song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT
      song
    FROM
      tracks
    INNER JOIN albums
      ON albums.asin = tracks.album
    WHERE
      title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
    SELECT 
      title, COUNT(tracks.*)
    FROM
      tracks
    INNER JOIN albums
      ON albums.asin = tracks.album
    WHERE
      song LIKE '%Heart%' 
    GROUP BY
      title
    ORDER BY
      COUNT(tracks.*) DESC, title
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT 
      song
    FROM
      tracks
    INNER JOIN albums
      ON albums.asin = tracks.album
    WHERE
      song = title 
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT 
      title
    FROM
      albums
    WHERE
      title = artist  
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT 
      song, COUNT(DISTINCT albums.*)
    FROM
      tracks
    INNER JOIN albums
      ON albums.asin = tracks.album
    GROUP BY
      song
    HAVING
      COUNT(DISTINCT albums.*) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT 
      title, price, COUNT(tracks.*)
    FROM
      tracks
    INNER JOIN albums
      ON albums.asin = tracks.album
    GROUP BY
      asin
    HAVING
      price / COUNT(tracks.*) < #{0.5}
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  execute(<<-SQL)
    SELECT 
      title, COUNT(tracks.*)
    FROM
      tracks
    INNER JOIN albums
      ON albums.asin = tracks.album
    GROUP BY
      asin
    ORDER BY
      COUNT(tracks.*) DESC, title DESC
    LIMIT 10
  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
    SELECT 
      artist, COUNT(DISTINCT albums.*)
    FROM
      albums
    INNER JOIN styles
      ON albums.asin = styles.album
    WHERE
      style LIKE '%Rock%'
    GROUP BY
      artist
    ORDER BY
      COUNT(DISTINCT albums.*) DESC
    LIMIT 1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.
  execute(<<-SQL)
    SELECT 
      style, SUM(albums_2.price) / SUM(albums_2.total_tracks)
    FROM
      albums
    INNER JOIN styles
      ON albums.asin = styles.album
    INNER JOIN (
      SELECT
        albums_b.price, albums_b.asin, COUNT(tracks_b.*) AS "total_tracks"
      FROM 
        albums albums_b
      INNER JOIN tracks tracks_b
        ON albums_b.asin = tracks_b.album
      WHERE
        albums_b.price IS NOT NULL
      GROUP BY
        albums_b.asin
    ) AS "albums_2"
      ON albums_2.asin = styles.album
    GROUP BY
      style
    ORDER BY
      SUM(albums_2.price) / SUM(albums_2.total_tracks) DESC, style ASC
    LIMIT 5
  SQL
end

#Normally: price_of_1_album / total_number_of_tracks_in_that_album
#Now     : price_of_1_album / total_number_of_tracks_for_a_specific_style_in_that_album
#style is for style of each album
          #style1     style2
          #album1     album4
          #album2     album5
          #album3     album6

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# # == Schema Information
# #
# # Table name: albums
# #
# #  asin        :string       not null, primary key
# #  title       :string
# #  artist      :string
# #  price       :float
# #  rdate       :date
# #  label       :string
# #  rank        :integer
# #
# # Table name: styles
# #
# # album        :string       not null
# # style        :string       not null
# #
# # Table name: tracks
# # album        :string       not null
# # disk         :integer      not null
# # posn         :integer      not null
# # song         :string

# require_relative './sqlzoo.rb'

# def alison_artist
#   # Select the name of the artist who recorded the song 'Alison'.
#   execute(<<-SQL)
#     SELECT
#       artist
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     WHERE 
#       song = 'Alison'
#   SQL
# end

# def exodus_artist
#   # Select the name of the artist who recorded the song 'Exodus'.
#   execute(<<-SQL)
#     SELECT
#       artist
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     WHERE 
#       song = 'Exodus'    
#   SQL
# end

# def blur_songs
#   # Select the `song` for each `track` on the album `Blur`.
#   execute(<<-SQL)
#     SELECT
#       song
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     WHERE 
#       albums.title = 'Blur'  
#   SQL
# end

# def heart_tracks
#   # For each album show the title and the total number of tracks containing
#   # the word 'Heart' (albums with no such tracks need not be shown). Order first by
#   # the number of such tracks, then by album title.
#   execute(<<-SQL)
#     SELECT
#       title, COUNT(song)
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     WHERE 
#       song LIKE '%Heart%'
#     GROUP BY
#       albums.title
#     ORDER BY
#       COUNT(song) DESC, title ASC
#   SQL
# end

# def title_tracks
#   # A 'title track' has a `song` that is the same as its album's `title`. Select
#   # the names of all the title tracks.
#   execute(<<-SQL)
#     SELECT
#       song
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     WHERE 
#       tracks.song = albums.title
#   SQL
# end

# def eponymous_albums
#   # An 'eponymous album' has a `title` that is the same as its recording
#   # artist's name. Select the titles of all the eponymous albums.
#   execute(<<-SQL)
#     SELECT
#       title
#     FROM
#       albums
#     WHERE 
#       title = artist
#   SQL
# end

# def song_title_counts
#   # Select the song names that appear on more than two albums. Also select the
#   # COUNT of times they show up.
#   execute(<<-SQL)
#     SELECT 
#       song, COUNT(DISTINCT title) 
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     GROUP BY
#       song   
#     HAVING 
#       COUNT(DISTINCT title) > 2
#   SQL
# end

# def best_value
#   # A "good value" album is one where the price per track is less than 50
#   # pence. Find the good value albums - show the title, the price and the number
#   # of tracks.
#   execute(<<-SQL)
#     SELECT DISTINCT
#       albums.title, albums.price, COUNT(tracks.*)
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     GROUP BY
#       asin
#     HAVING
#       albums.price / COUNT(tracks.*) < #{0.5}
#   SQL
# end

# def top_track_counts
#   # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
#   # tracks. List the top 10 albums. Select both the album title and the track
#   # count, and order by both track count and title (descending).
#   execute(<<-SQL)
#     SELECT
#       albums.title, COUNT(tracks.*)
#     FROM
#       albums
#     INNER JOIN tracks
#       ON asin = album
#     GROUP BY
#       asin
#     ORDER BY
#       COUNT(tracks.*) DESC, title DESC
#     LIMIT 10 
#   SQL
# end

# def rock_superstars
#   # Select the artist who has recorded the most rock albums, as well as the
#   # number of albums. HINT: use LIKE '%Rock%' in your query.
#   execute(<<-SQL)
#     SELECT
#       artist, COUNT(DISTINCT title)
#     FROM  
#       albums
#     INNER JOIN styles
#       ON asin = album
#      WHERE
#       style LIKE '%Rock%'     
#     GROUP BY
#       artist
#     ORDER BY
#       COUNT(DISTINCT title) DESC
#     LIMIT 1
#   SQL
# end

# def expensive_tastes
#   # Select the five styles of music with the highest average price per track,
#   # along with the price per track. One or more of each aggregate functions,
#   # subqueries, and joins will be required.
#   #
#   # HINT: Start by getting the number of tracks per album. You can do this in a
#   # subquery. Next, JOIN the styles table to this result and use aggregates to
#   # determine the average price per track.
#   execute(<<-SQL)
#     SELECT
#       style, SUM(album_2.price) / SUM(album_2.total_tracks_per_album)
#     FROM
#       styles
#     INNER JOIN ( 
#       SELECT 
#         albums.asin, albums.price, COUNT(tracks.*) AS "total_tracks_per_album"
#       FROM
#         albums
#       INNER JOIN tracks
#         ON asin = album
#       WHERE 
#         price IS NOT NULL
#       GROUP BY
#         asin
#       ) AS "album_2" ON album_2.asin = styles.album
#     GROUP BY
#       style
#     ORDER BY
#       SUM(album_2.price) / SUM(album_2.total_tracks_per_album) DESC, style ASC
#     LIMIT 5  
#   SQL
# end

# #Calculate average first, not as accurate, should calculate the total tracks per album first, because some albums might got eliminated when group by style
#     # SELECT
#     #   style, SUM(album_2.price_per_track) / COUNT(album_2.price_per_track) 
#     # FROM
#     #   styles
#     # INNER JOIN ( 
#     #   SELECT 
#     #     albums.asin, albums.price / COUNT(tracks.*) AS "price_per_track"
#     #   FROM
#     #     albums
#     #   INNER JOIN tracks
#     #     ON asin = album
#     #   WHERE
#     #     price IS NOT NULL
#     #   GROUP BY
#     #     asin
#     #   ) AS "album_2" ON album_2.asin = styles.album
#     # GROUP BY
#     #   style
#     # ORDER BY
#     #   SUM(album_2.price_per_track) / COUNT(album_2.price_per_track) DESC, style ASC
#     # LIMIT 5
    