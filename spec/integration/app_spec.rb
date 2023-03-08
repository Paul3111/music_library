require 'rack/test'
require 'spec_helper'
require_relative '../../app'

RSpec.describe Application do
    include Rack::Test::Methods

    let(:app) { Application.new }

  #context 'GET /' do
  #  it "Returns the HMTL hello message with the given name" do
  #    response = get('/', name: "Paul")

#      expect(response.body).to include('<h1>Hello Paul!</h1>')
#      expect(response.body).to include('<img src= "hello.jpg"/>')
#    end

#    it "Returns the HMTL hello message with the given name" do
#      response = get('/', name: "Alice")
  
#      expect(response.body).to include('<h1>Hello Alice!</h1>')
#      expect(response.body).to include('<img src= "hello.jpg"/>')
#    end
#  end

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