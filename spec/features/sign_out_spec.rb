feature 'Sign out' do
  scenario 'User can sign out' do
    sign_up
    click_link 'Sign out'
    p page.current_path
    expect(page).to have_content("Logged out successfully.")
    expect(page).not_to have_content("Welcome, Joe.")
    p page.current_path
  end
end
