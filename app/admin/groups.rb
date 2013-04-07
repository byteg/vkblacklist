ActiveAdmin.register Group do     
  index do
    column :id
    column :name
    column :title
    column :url
    column :item_id
    column :banned
    column :checked
    column :ban_until
    default_actions                   
  end                                 

  filter :id
  filter :name
  filter :banned
  filter :item_id
  filter :checked
  filter :ban_until
end                                   
