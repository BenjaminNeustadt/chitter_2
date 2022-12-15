require 'pg'
require_relative './database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('chit_test')
else
  DatabaseConnection.setup('chit_chat')
end

