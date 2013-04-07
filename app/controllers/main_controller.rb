class MainController < ApplicationController
  def index
  	@group = Group.new
  end
end
