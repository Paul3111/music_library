ALBUM REPOSITORY Model and Repository Classes Design Recipe

1. Design and create the Table

Using existing table (albums)

2. Create Test SQL seeds

-- (file: spec/seeds_albums_test.sql)

TRUNCATE TABLE albums RESTART IDENTITY;
INSERT INTO albums (title, release_year, artist_id) VALUES ('Album1', '1999', 5);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Album2', '2001', 5);

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 music_library_test < seeds_albums_test.sql

3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: students

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Student

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end

5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    SELECT id, title, release_year, artist_id FROM albums;
    # Returns an array of Student objects.
  end
end

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # =>  2

albums[0].id # =>  1
albums[0].title # =>  'Album1'
albums[0].release_year # =>  '1999'
albums[0].artist_id # =>  '5'

albums[0].id # =>  2
albums[0].title # =>  'Album2'
albums[0].release_year # =>  '2001'
albums[0].artist_id # =>  '5'

7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/album_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'albums' })
  connection.exec(seed_sql)
end

describe AlbumsRepository do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.