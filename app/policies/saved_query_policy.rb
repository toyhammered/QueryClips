class SavedQueryPolicy < ApplicationPolicy
  def read?
    case @record.privacy
    when 'public'
      # accessible to all
      true
    when 'protected'
      # accessible when you have an account
      !@user.nil?
    when 'private'
      # only accessible to the owner
      @record.user == @user
    end
  end

  def edit?
    @record.user == @user
  end
end
