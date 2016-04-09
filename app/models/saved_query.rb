class SavedQuery < ActiveRecord::Base
  include FriendlyId
  belongs_to :database_connection
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug
end
