class SavedQuery < ActiveRecord::Base
  include FriendlyId

  validates_presence_of :name, :slug

  friendly_id :name, use: :slugged

  belongs_to :database_connection
  belongs_to :user

  def self.recent
    SavedQuery.order("created_at DESC")
  end
end
