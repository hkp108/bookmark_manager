require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String, format: :email_address, required: true, unique: true,
            messages: {
              format: 'Invalid email format.',
              is_unique: 'Email already registered'
            }
  property :password_hash, Text

  attr_accessor :password_confirmation
  attr_reader :password
  validates_confirmation_of :password,
  :message => "Passwords did not match."

  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  def self.authenticate(email: , password:)
    user = User.first(email: email)
    return user if user && BCrypt::Password.new(user.password_hash) == password
  end
end
