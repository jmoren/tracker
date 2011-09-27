class ActivitiesController < ApplicationController
  
  def index
  
  end

  def destroy
    activity = Activity.find(params[:id])
    @id = activity.id
    activity.destroy  
  end

end
