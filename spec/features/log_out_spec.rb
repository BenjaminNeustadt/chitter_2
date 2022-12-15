feature "Log-Out" do

  scenario "redirects to /peeps" do
    create_user_from_database
    visit '/users/log_in'
    fill_in 'email', with: 'jelly@jelly.com'
    fill_in 'password', with: 'passworD1!'
    click_on 'log-in'
    click_on 'Log-Out'

    expect(current_path).to eq "/peeps"
  end

  scenario "ends the user session" do
    create_user_from_database
    visit '/users/log_in'
    fill_in 'email', with: 'jelly@jelly.com'
    fill_in 'password', with: 'passworD1!'
    click_on 'log-in'
    click_on 'Log-Out'

    expect(page).to have_content "Log-In"
  end

end

