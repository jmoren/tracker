class HomeController < ApplicationController
  layout 'home'
  skip_before_filter :login_required, :only => [:index]
  def index
    if current_user
      redirect_to projects_path
    end
  end

end
