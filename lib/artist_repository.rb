require_relative 'artist'
require_relative 'database_connection'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result = DatabaseConnection.exec_params(sql, [])
    
    artists_list = []

    result.each do |item|
      artist = Artist.new
      artist.id = item['id']
      artist.name = item['name']
      artist.genre = item['genre']
      artists_list << item
    end
    
    return artists_list
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    record = result[0]
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    return artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    result = DatabaseConnection.exec_params(sql, [artist.name, artist.genre])
    return result
  end
end