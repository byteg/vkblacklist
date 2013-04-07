class GroupsController < ApplicationController

  def by_group_id
    @complaint = Group.where(:item_id => params[:group_id]).first

    respond_to do |format|
      format.xml { render xml: @complaint }
      format.json { render json: @complaint }
    end
  end

  def by_name
    @complaint = Group.where(:name => params[:group_name]).first

    respond_to do |format|
      format.xml { render xml: @complaint }
      format.json { render json: @complaint }
    end
  end 

  def exists
    @group = Group.find_by_url(params[:url])
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: @group.nil? ? I18n.t('groups.not_in_list') : I18n.t('groups.in_list', :ban_until => @group.ban_until) }
      format.json { render json: { :result => @group.nil? ? 0 : 1 } }
    end
  end

end
