class SavedQueryPolicy < ApplicationPolicy
  def read?
    !@user.nil?
  end

  def edit?
    @record.user == @user
  end
end
