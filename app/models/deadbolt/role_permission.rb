class Deadbolt::RolePermission < ActiveRecord::Base

  belongs_to :role
  belongs_to :permission, :class_name => "Deadbolt::Permission"

  validates :role, :permission, :presence => true
  validates_associated :role, :permission

  def target
    if target_id
      target_class = permission.target_type.constantize
      target_class.find(target_id)
    end
  end

  def human_name
    if target_id
      record = target
      name = record.send([:human_name, :label, :title, :name, :email, :to_s].find do |m|
        record.respond_to?(m)
      end)
      "can #{Deadbolt::Permission::ActionDescriptions[permission.action]} \"#{name}\""
    else
      permission.human_name
    end
  end
end
