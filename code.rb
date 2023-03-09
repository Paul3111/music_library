require './lib/database_connection'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/album_repository'
require './lib/artist_repository'

DatabaseConnection.connect('music_library_test')

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
end

# artist.erb

<html>
  <head></head>
  <body>
    <h1>Title: <%= @artist.name %></h1>
    <p>
      Genre: <%= @artist.genre %>
    </p>
    <a href="/artists/">Go back</a>
  </body>
</html>

# app_spec.rb

require 'rack/test'
require 'spec_helper'
require_relative '../../app'

RSpec.describe Application do
    include Rack::Test::Methods

    let(:app) { Application.new }

  context "GET /" do
    it "Returns an HTML list of names." do
      response = get('/')
      expect(response.body).to include('<p>Paul</p>')
      expect(response.body).to include('<p>Alice</p>')
      expect(response.body).to include('<p>George</p>')
      expect(response.body).to include('<p>Natalia</p>')
    end
  end

  context "GET /albums/:id" do
    it "Returns HTML for album2." do
        response = get('/albums/2')
        expect(response.status).to eq (200)
        expect(response.body).to include('<h1>Title: Album2</h1>')
        expect(response.body).to include('Release year: 2001')
        expect(response.body).to include('Artist: Michael Jackson')
    end
  end

  context "GET /albums/" do
    it "Returns HTML with all albums." do
      response = get('albums/')
      expect(response.status).to eq (200)
      expect(response.body).to include ('Title: Album2')
      expect(response.body).to include ('Title: Album1')
      expect(response.body).to include ('Released: 1999')
    end
  end

  context "GET /artist/:id" do
    it "Returns HTML with details for a single artist." do
      response = get('/artist/1')
      
      expect(response.status).to eq 200
      expect(response.name).to eq "Michael Jackson"
      expect(response.genre).to eq "Pop"
    end
  end
end