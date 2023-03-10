require 'pg'

class DatabaseConnection

  def self.connect
    #@connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
    if ENV['DATABASE_URL'] != nil
      @connection = PG.connect(ENV['DATABASE_URL'])
      return
    end
    if ENV['ENV'] == 'test'
      database_name = 'music_library_test'
    else
      database_name = 'music_library'
    end
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end

  # This method executes an SQL query 
  # on the database, providing some optional parameters
  # (you will learn a bit later about when to provide these parameters).
  def self.exec_params(query, params)
   if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end