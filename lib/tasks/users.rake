namespace :deadbolt do

  namespace :users do

    def new_password
      (0..8).map do
        letters = ('a'..'z').to_a.concat(('A'..'Z').to_a)
        rejected = %w(i l o)
        set = letters.reject { |l| rejected.include? l.downcase }
        set = set.concat(['2', '3', '6', '7', '8', '9'])
        set = set.concat([',', '|', ';', '-', '_'])
        set[rand(set.size)]
      end.join('')
    end

    desc "Creates an admin user with random password"
    task :seed_admin, :email, :needs => :environment do |task, args|
      pass = new_password
      admin = Deadbolt::User.create(:email => args[:email], :password => pass,
        :password_confirmation => pass)
      admin.update_attribute(:admin, true)
      puts "created admin user: #{args[:email]} with password: #{pass}"
    end
  end
end
