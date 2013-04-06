ActiveAdmin.register Account do     
  index do
    column :id
    column :ban_url
    column :unban_url
    default_actions                   
  end                                 

  filter :id
  filter :ban_url
  filter :unban_url
end                                   
