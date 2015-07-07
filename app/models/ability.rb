class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new # guest user (not logged in)
    if user.new_record?
      guest
    else
      permitted(user)
    end
  end

  def guest
    can [:index, :list, :search, :show], NewThread
  end

  def permitted(user)
    guest
    can [:new, :create], NewThread
    can [:edit, :update, :destroy], NewThread do |new_thread|
      new_thread.try(:user_id) == user.id
    end
  end
end
