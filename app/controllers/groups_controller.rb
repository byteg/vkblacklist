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
      format.html { redirect_to root_path, notice: @group.nil? || !@group.banned? ? I18n.t('groups.not_in_list') : I18n.t('groups.in_list', :ban_until => l(@group.ban_until.in_time_zone('Moscow'), :format => :long)) }
      format.json { render json: { :result => @group.nil? || !@group.banned? ? 0 : 1 } }
    end
  end

end
