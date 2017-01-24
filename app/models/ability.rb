class Ability
  include CanCan::Ability

  def initialize(user)
    if user.respond_to?(:has_spree_role?)
      can [:manage], Message
    end
  end
end