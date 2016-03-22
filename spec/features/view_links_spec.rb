

feature 'view links' do
  scenario 'shows links on homepage' do
    Links.create(url: 'www.google.com')
    visit '/'
    expect(page).to have_content("www.google.com")
  end
  # scenario 'shows links on homepage' do
  #   visit '/'
  #   click_button ('Add link')
  #   fill_in :url, with: 'Google'
  #   click_button 'Add'
  #   click_button 'See all links'
  #   expect(page).not_to have_content("There are no links")
  #   expect(page).to have_content("Google")
  # end

end
