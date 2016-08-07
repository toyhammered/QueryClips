class Visualization < ActiveRecord::Base
  include FriendlyId

  friendly_id :name, use: :slugged
  
  belongs_to :saved_query
end
