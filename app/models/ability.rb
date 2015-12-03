# This class is used by the `cancancan` gem to control who can see what parts of the application
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.find_by(netid: session[:cas_user])
    superusers = %w{fr88 sk969}

    if superusers.include? user.netid
      can :manage, :all
    else
      can :create, Event
      can :manage, Event, {:users => { :id => user.id }}
      can :create, AttendanceEntry
      can :manage, AttendanceEntry, {:event => {:users => { :id => user.id }}}
      can [:read, :update], User, {:id => user.id}
      can :read, :homepage
      can :read, :personlookup
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
