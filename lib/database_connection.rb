require 'pg'

class DatabaseConnection
  def self.connect
    # If the environment variable (set by Render)
    # is present, use this to open the connection.
    if ENV['DATABASE_URL'] != nil
      @connection = PG.connect(ENV['DATABASE_URL'])
      return
    end
  
    if ENV['ENV'] == 'test'
      database_name = 'chit_test'
    else
      database_name = 'chit_chat'
    end
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end

  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

end
