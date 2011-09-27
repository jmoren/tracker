class ApplicationController < ActionController::Base
  include ControllerAuthentication
  before_filter :login_required, :load_project
  protect_from_forgery

  def load_project
    if session[:project_id]
      @project = Project.find(session[:project_id])
    else
      @project = nil
    end
  end
end
