feature 'User sign in' do
 scenario 'User can sign in' do
   User.create(name: 'Joe',
               email: 'joe@makersacademy.com',
               password: 'fish',
               password_confirmation: 'fish')
   sign_in(email:'joe@makersacademy.com',
          password: 'fish')
   click_button 'Sign in'
   expect(page).to have_content('Successfully signed in as joe@makersacademy.com')
 end

 scenario 'User sign in wrong password' do
   User.create(name: 'Joe',
               email: 'joe@makersacademy.com',
               password: 'fish')
   sign_in(email:'joe@makersacademy.com',
          password: 'kangeroo')
   click_button 'Sign in'
   expect(page).to have_content('Invalid email or password. Please try again.')
 end
end
