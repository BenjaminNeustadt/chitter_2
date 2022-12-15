feature "Post peep" do
  scenario "user can not post unless signed in" do
    visit '/peeps/new'

    expect(current_path).to eq '/peeps'
  end

  scenario "does not appear if user not signed-in" do
    visit '/peeps'

    expect(current_path).to eq '/peeps'
    expect(page).to have_no_button('Post Peep')
  end

  scenario "a user can post if logged in" do
    create_user_from_database
    visit '/users/log_in'
    fill_in 'email', with: 'jelly@jelly.com'
    fill_in 'password', with: 'passworD1!'
    click_on 'log-in'

    expect(current_path).to eq '/peeps'
    expect(page).to have_button('Post Peep')
  end
end

