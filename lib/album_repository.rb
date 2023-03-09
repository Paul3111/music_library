require_relative 'album'
require_relative 'database_connection'

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])
    
    albums_list = []

    result.each do |item|
      album = Album.new
      album.id = item['id']
      album.title = item['title']
      album.release_year = item['release_year']
      album.artist_id = item['artist_id']
      albums_list << item
    end
    
    return albums_list
  end

  def find(id)
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    record = result[0]
    album = Album.new
    album.id = record['id'].to_i
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id'].to_i
    return album
  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    result_set = DatabaseConnection.exec_params(sql, [album.title, album.release_year, album.artist_id])
    return album
  end
end