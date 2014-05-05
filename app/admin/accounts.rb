ActiveAdmin.register Account do
  permit_params :ban_url, :unban_url, :token

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
