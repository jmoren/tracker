class ProjectsController < ApplicationController
  before_filter :load_user, :store_target_location
  before_filter :allow_only_owner, :except => [:new, :create, :index]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.user = current_user
    if @project.save
      redirect_to @project, :notice => "Successfully created project."
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => "Successfully destroyed project."
  end

  def load_user
    @user = current_user
  end
  def allow_only_owner
    redirect_to_target_or_default root_url if current_project.user != current_user
  end
  def current_project
    Project.find(params[:id])
  end
end
