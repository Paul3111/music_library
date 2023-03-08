require './lib/database_connection'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/album_repository'
require './lib/artist_repository'

DatabaseConnection.connect('music_library_test')

#sql = 'SELECT * FROM books;'
#result = DatabaseConnection.exec_params(sql, [])

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/albums' do
    repo = AlbumRepository.new
    albums = repo.all

   response = albums.map do |album|
     album.title
   end.join(',')
  end
  
  #get '/' do
   #@name = params[:name]
   #@cohort = "February 2023"
   # return erb(:index)
  #end

  get '/' do
   @names = ['Paul','Alice','George','Natalia']
   return erb(:index)
  end

  get '/albums/:id' do
   repo = AlbumRepository.new
   artist_repo = ArtistRepository.new
   @id = params[:id]
   @album = repo.find(@id)
   @artist = artist_repo.find(@album.artist_id)

   return erb(:album)
  end

  get '/albums/' do
   repo = AlbumRepository.new
   @albums = repo.all
   return erb(:albums)
  end
end