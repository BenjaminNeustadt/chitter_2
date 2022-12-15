feature "Log-In" do

  scenario "redirects to log-in page" do
    visit '/peeps'
    click_on 'Log-In'

    expect(current_path).to eq '/users/log_in'
  end

  scenario "to /peeps after log-in" do
    create_user_from_database
    visit '/peeps'
    click_on 'Log-In'

    expect(current_path).to eq '/users/log_in'

    fill_in 'email', with: 'jelly@jelly.com'
    fill_in 'password', with: 'passworD1!'
    click_on 'log-in'

    expect(current_path).to eq "/peeps"
    expect(page).to have_content "Log-Out"
  end

end

