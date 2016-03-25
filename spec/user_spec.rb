describe User do

  let(:user) do
    User.create(name:'Joe', email: 'me@joe.com', password: 'fish', password_confirmation: 'fish')
  end

  describe '#authenticate' do
    it 'should return user if password is correct' do
      user
      expect(User.authenticate(email: 'me@joe.com', password: 'fish')).to eq user
    end

    it 'does not authenticate when given an incorrect password' do
      expect(User.authenticate(email: user.email, password: 'wrongpassword')).to be_nil
    end
  end
end
