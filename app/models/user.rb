require 'bcrypt'
class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  property :password_hash, Text

  def password=(password)
    self.password_hash = BCrypt::Password.create(password)
  end
end
