class Ability
  include CanCan::Ability

  def initialize(user=nil)
    if user
      if user.admin?
        can :manage, :all
      end
      add_dynamic_abilities user
    end
  end

  private

  def add_dynamic_abilities(user)
    user.roles.each do |role|
      role.role_permissions.each do |role_permission|
        permission = role_permission.permission
        action = permission.action.to_sym
        target_class = permission.target_type.constantize
        unless role_permission.target
          can action, target_class
        else
          can action, role_permission.target
        end
      end
    end
  end
end
