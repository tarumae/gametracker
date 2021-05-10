class TrackerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.trackers
    end
  end

  def new?
    create?
  end

  def create?
    true
  end
  
  def show?
    record.user == user
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

end
