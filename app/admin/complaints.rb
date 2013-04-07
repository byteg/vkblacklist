ActiveAdmin.register Complaint do     
  index do
    column :id
    column :group
    column :account_id
    column :comment
    default_actions                   
  end                                 

  filter :id
  filter :group_id, :as => :numeric
  filter :account_id, :as => :numeric
end                                   
