class TourPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end
  
  # private

  # def user_is_host?
  #   user == record.user
  # end
end
