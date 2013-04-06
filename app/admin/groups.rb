ActiveAdmin.register Group do     
  index do
    column :id
    column :name
    column :item_id
    column :checked
    column :ban_until
    default_actions                   
  end                                 

  filter :id
  filter :name
  filter :item_id
  filter :checked
  filter :ban_until
end                                   
