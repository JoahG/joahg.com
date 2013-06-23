class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :login, :password, :password_confirmation, :name, :admin

  has_many :posts
end
