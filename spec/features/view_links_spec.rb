require 'database_cleaner'
feature 'view links' do
  scenario 'shows links on homepage' do
    visit '/'
    click_button ('Add link')
    fill_in :url, with: 'www.google.com'
    fill_in :title, with: 'Google'
    click_button 'Add'
    click_button 'See all links'
    expect(page).to have_content("www.google.com")
    expect(page).to have_content("Google")
  end
end
