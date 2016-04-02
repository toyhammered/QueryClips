class DatabaseConnection < ActiveRecord::Base
  has_many :saved_queries
end
