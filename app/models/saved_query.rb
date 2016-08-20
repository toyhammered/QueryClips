class SavedQuery < ActiveRecord::Base
  include FriendlyId

  validates_presence_of :name, :slug

  friendly_id :name, use: :slugged

  belongs_to :database_connection
  belongs_to :user

  # Class methods / scopes
  
  def self.recent
    SavedQuery.order("created_at DESC")
  end

  def self.public
    SavedQuery.where(privacy: 'public')
  end

  def self.privacy_options
    ["public", "protected", "private"]
  end

  def self.daily_digest
    SavedQuery.where(daily_digest: true)
  end

  # Instance methods

  def toggle_daily_digest
    if self.daily_digest
      self.daily_digest = false
    else
      self.daily_digest = true
    end
  end
end
