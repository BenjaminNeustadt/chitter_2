require 'pg'

class User

  def self.all
    user_all = DatabaseConnection.query("SELECT * FROM users;")
    user_all.map do |user|
      new(
        user['id'],
        user['username'],
        user['email'])
    end
  end

  def self.create(username:, email:, password:)
    user_create = DatabaseConnection.query(
      "INSERT INTO users (username, email, password)
      VALUES ($1, $2, $3) RETURNING id, username, email, password",
      [username, email, password]
    )
    new(
      user_create.first['email'],
      user_create.first['username'],
      user_create.first['id'],
      user_create.first['password']
    )
  end

  def self.find(id:)
    return nil unless id
    user_exist = DatabaseConnection.query("SELECT * FROM users WHERE id = $1", [id])
    new(
      user_exist.first['id'],
      user_exist.first['username'],
      user_exist.first['email'],
    )
  end

  def self.authenticate(email:, password:)
    user_session = DatabaseConnection.query(
      "SELECT * FROM users WHERE email = $1 AND password = $2",
      [email, password]
    )
    return false unless user_session.any?
    new(
      user_session.first['email'],
      user_session.first['username'],
      user_session.first['id']
    )
  end

  def initialize(email, username, id, password = false )
    @id       = id
    @username = username
    @email    = email
    @password = password
  end

  attr_reader :id,
              :username,
              :email

end

