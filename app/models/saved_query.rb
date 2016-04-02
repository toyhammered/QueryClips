class SavedQuery < ActiveRecord::Base
  belongs_to :database_connection
end
