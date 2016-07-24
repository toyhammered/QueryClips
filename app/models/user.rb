class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :password, length: { minimum: 6 }

  has_secure_password
  
  has_many :database_connections
  has_many :saved_queries
end
