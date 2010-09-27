class Deadbolt::Permission < ActiveRecord::Base

  Actions = %w(manage read create update destroy)
  ActionDescriptions = {
    "manage" => "manage (view, add, modify, delete)",
    "read" => "view",
    "create" => "add",
    "update" => "modify",
    "destroy" => "delete"
  }

  has_many :role_permissions, :dependent => :destroy
  has_many :roles, :through => :role_permissions

  validates :action, :target_type, :presence => true
  validates_inclusion_of :action, :in => Actions

  def human_name
    "can #{ActionDescriptions[action]} #{target_type.pluralize}"
  end
end
