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

  get '/albums/new' do
    return erb(:album_form)
  end

  post '/albums' do
    if invalid_request_parameters?
      status 400
      return ''
    end
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
    repo.create(new_album)
    return erb(:album_confirmation)
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

  get '/artist/:id' do
   repo = ArtistRepository.new
   @artist = repo.find(params[:id])
   return erb(:artist)
  end

  get '/artists/' do
   repo = ArtistRepository.new
   @artists = repo.all
   return erb(:artists)
  end

  def invalid_request_parameters?
    return true if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
    return true if params[:title] == "" || params[:release_year] ==  "" || params[:artist_id] == ""  
    return false
  end
end