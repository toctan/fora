class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user
      can :create, [Topic, Reply]
      can :manage, :all if user.admin?
    end
  end
end
