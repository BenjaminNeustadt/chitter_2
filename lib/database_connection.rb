require 'pg'

class DatabaseConnection

  def self.setup(dbname)

    if ENV['DATABASE_URL'] != nil
      @connection = PG.connect(ENV['DATABASE_URL'])
      return
    else
      @connection = PG.connect(dbname: dbname)
    end
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

end
