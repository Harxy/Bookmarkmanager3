require 'data_mapper'
require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader   :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, required: true
  property :password_digest, Text

  def password= password
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  validates_confirmation_of :password
  validates_uniqueness_of :email

end
