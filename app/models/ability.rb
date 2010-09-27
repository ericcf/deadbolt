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
        if role_permission.target_id.nil?
          can action, target_class
        else
          can action, target_class, :id => role_permission.target_id
        end
      end
    end
  end
end
