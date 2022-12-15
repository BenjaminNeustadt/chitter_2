require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'chit_test')
  connection.exec("TRUNCATE peeps, users;")
end

