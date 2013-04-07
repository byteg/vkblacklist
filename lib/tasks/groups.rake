namespace :groups do

  task :check => :environment do
    Group.check_unbanned
  end

end