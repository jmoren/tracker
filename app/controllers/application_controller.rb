class ApplicationController < ActionController::Base
  #include SslRequirement
  include ControllerAuthentication
  before_filter :login_required
  before_filter :set_current_project
  protect_from_forgery

  def set_current_project
    @current_project = nil
    if session[:current_project_id]
      @current_project = Project.find(session[:current_project_id])
    end
  end
  
end
