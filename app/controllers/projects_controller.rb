class ProjectsController < ApplicationController
  before_filter :load_user, :store_target_location
  before_filter :allow_members, :except => [:new, :create, :index]
  before_filter :allow_owner, :only => [:edit, :update, :destroy]
  def index
    @projects = Project.all
  end

  def show
    current_project
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
    current_project
  end

  def update
    if current_project.update_attributes(params[:project])
      redirect_to @project, :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def destroy
    current_project.destroy
    redirect_to projects_url, :notice => "Successfully destroyed project."
  end

  def add_collaborator
    @user = User.find_by_email(params[:email])
    @collaborator = Collaborator.new(:user_id => @user.id, :role => params[:role])
    current_project.collaborators << @collaborator
    respond_to do |format|
      format.js { render :add_collaborator }
    end 
  end
  
  def remove_collaborator
    collaborator = current_project.collaborators.find(params[:user])
    @id = collaborator.id
    if collaborator
      collaborator.destroy
      text ="Se elimino el colaborador"
    else
      text ="No se pudo encontrar el colaborador"
    end
    respond_to do |format|
      format.js {render :remove_collaborator  }
    end
  end
  
  def update_collaborator(option)
    @collaborator = Collaborator.find(params[:user])
    if @collaborator.update(option)
      text = "Collaborator #{@collaborator.user.username} was successfully updated"
    else
      text = "Sorry, we couldn't do it..."
    end
    render :text => text
  end

private
  
  def load_user
    @user = current_user
  end
  
  def allow_owner
    unless current_project.user == current_user
      redirect_to current_project, :alert => "You don't have permission to do this"
    end
  end 
  def allow_members
    if !current_project.is_collaborator?(current_user)
      redirect_to root_url, :alert => "You cant see this project."
    end
  end
  
  def current_project
    @project ||= Project.find(params[:id])
  end
end
