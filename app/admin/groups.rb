ActiveAdmin.register Group do     
  member_action :unban, :method => :put do
    group = Group.find(params[:id])
    Unbanner.new(group).unban!
    redirect_to :action => :show
  end

  member_action :ban, :method => :put do
    group = Group.find(params[:id])
    Banner.new(group).ban!
    redirect_to :action => :show
  end

  action_item :only => :show do
    link_to("Unban", unban_admin_group_path(resource), :method => :put) if resource.banned?
  end

  action_item :only => :show do
    link_to("Ban", ban_admin_group_path(resource), :method => :put) unless resource.banned?
  end

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

  controller do
    def permitted_params
      params.permit!
    end
  end



end                                   
