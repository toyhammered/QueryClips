class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :password, length: { minimum: 6 }, on: :create

  has_secure_password
  
  has_many :database_connections
  has_many :saved_queries

  def admin?
    admin
  end

  def query_count
    saved_queries.count
  end
end
