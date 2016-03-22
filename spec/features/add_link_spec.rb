feature 'add link' do
  scenario "fill in link info" do
    visit '/'
    click_button 'Add link'
    expect(page).to have_field('url')
    expect(page).to have_button('Add')
  end
end
