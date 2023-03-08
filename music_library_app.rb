require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

#artist_repository = ArtistRepository.new
album_repo = AlbumRepository.new

album_repo.all.each do |record|
  p record
end