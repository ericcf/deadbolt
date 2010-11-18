namespace :deadbolt do

  namespace :permissions do

    def create_permission(action, target_class)
      if Deadbolt::Permission.where(:action => action, :target_type => target_class).empty?
        Deadbolt::Permission.create(:action => action, :target_type => target_class)
      end
    end

    desc "Adds Permission records for Deadbolt"
    task :seed => :environment do
      Deadbolt::Permission::Actions.each do |action|
        [
          "Deadbolt::Permission",
          "Deadbolt::Role",
          "Deadbolt::User"
        ].each do |target_class|
          create_permission action, target_class
        end
      end
    end

    desc "Adds Permission records for specified class, e.g. rake deadbolt:permissions:create[Bagel]"
    task :create, :target_class, :needs => :environment do |task, args|
      puts "adding permissions for #{args[:target_class]}:"
      Deadbolt::Permission::Actions.each do |action|
        permission = create_permission action, args[:target_class]
        puts permission.human_name
      end
    end
  end
end
