class BugsController < ApplicationController
  def index
    @bugs = Bug.all
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(params[:bug])
    if @bug.save
      redirect_to @bug, :notice => "Successfully created bug."
    else
      render :action => 'new'
    end
  end

  def edit
    @bug = Bug.find(params[:id])
  end

  def update
    @bug = Bug.find(params[:id])
    if @bug.update_attributes(params[:bug])
      redirect_to @bug, :notice  => "Successfully updated bug."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    redirect_to bugs_url, :notice => "Successfully destroyed bug."
  end
end
