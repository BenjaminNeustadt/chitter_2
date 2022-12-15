require 'pg'

feature 'Viewing peeps' do

  scenario 'A user can see peeps' do
    connection = PG.connect(dbname: 'chit_test')

    connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")
    connection.exec("INSERT INTO peeps (content) VALUES ('second peep');")
    connection.exec("INSERT INTO peeps (content) VALUES ('third peep');")

    visit('/peeps')

    expect(page).to have_content "first peep"
    expect(page).to have_content "second peep"
    expect(page).to have_content "third peep"
  end

end

