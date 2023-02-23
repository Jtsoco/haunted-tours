class Host::BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
    #   scope.all
      user.bookings_as_host
    end
  end
end
