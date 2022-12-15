feature 'Index page' do

  scenario 'has a log-in button if there is no session' do
    visit('/peeps')

    expect(page).to have_content "Log-In"
  end

  scenario 'has a log-out button if there is a session' do
    create_user_from_database
    visit('/peeps')
    click_on "Log-In"

    expect(current_path).to eq "/users/log_in"

    fill_in 'email', with: 'jelly@jelly.com'
    fill_in 'password', with: 'passworD1!'
    click_on 'log-in'

    expect(current_path).to eq "/peeps"
    expect(page).to have_content "Log-Out"
  end

end
