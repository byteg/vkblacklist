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


  member_action :unban, :method => :put do
    group = Group.find(params[:id])
    group.unban!
    redirect_to :action => :show
  end

  member_action :ban, :method => :put do
    group = Group.find(params[:id])
    group.ban!
    redirect_to :action => :show
  end

  action_item do
    link_to "Unban", unban_admin_group_path(resource), :method => :put
  end

  action_item do
    link_to "Ban", ban_admin_group_path(resource), :method => :put
  end

end                                   
