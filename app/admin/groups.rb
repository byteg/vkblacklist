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
    redirect_to {:action => :show}, {:notice => "Unbanned!"}
  end

  member_action :ban, :method => :put do
    group = Group.find(params[:id])
    group.ban!
    redirect_to {:action => :show}, {:notice => "Banned!"}
  end

end                                   
