require 'pg'

class Peep

  RE = REGULAR_EXPRESSION = {date_hour_minute: /^\d*-\d*-\d*\s\d+:\d+/}
  private_constant :RE, :REGULAR_EXPRESSION

  def self.all
    query_result = DatabaseConnection.query("SELECT * FROM peeps;")
      .reverse_each
      .map do |peep|
      new(
        content: peep['content'],
        time_stamp: peep['time_stamp'],
        user_id: peep['user_id'].to_i,
      )
    end
  end

  def get_author(user_id)
    return unless user_id
    DatabaseConnection.query("SELECT * FROM users WHERE id = #{user_id};")
      .first['username']
  end

  def self.create(content:, user_id:)
    DatabaseConnection
      .query(
        "INSERT INTO peeps (content, user_id)
         VALUES('#{content}', #{user_id})"
    )
  end

  def initialize(content:, time_stamp:, user_id: )
    @content = content
    @time_stamp = time_stamp[RE[:date_hour_minute]]
    @user_id = user_id
  end

  attr_reader :content, :time_stamp, :user_id

end
