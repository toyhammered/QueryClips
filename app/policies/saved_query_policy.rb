class SavedQueryPolicy < ApplicationPolicy
  def read?
    return true if @record.id.nil?
    return true if @user.admin?
    
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
    return true if @record.id.nil? # a new record
    return true if @user.admin?
    
    @record.user == @user
  end
end
