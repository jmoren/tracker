class ProjectsController < ApplicationController
  respond_to :json, :html
  before_filter :load_user, :store_target_location
  before_filter :allow_members, :except => [:new, :create, :index, :update_collaborator]
  before_filter :allow_owner, :only => [:edit, :update, :destroy]
  before_filter :forget_current_project, :only => [:new, :create, :destroy]
  before_filter :store_current_project,:set_current_project, :only =>[:show]
  def set_current_project
    @current_project = nil
    if session[:current_project_id]
      @current_project = Project.find(session[:current_project_id])
    end
  end
  def store_current_project
    session[:current_project_id] = current_project.id
  end
  def forget_current_project
    session[:current_project_id] = nil
  end
  def index
    session[:current_project_id] = nil
    if params[:q] && !params[:q].blank?
      @projects = current_user.projects.where('name LIKE ?', "%" + params[:q] + "%")
    else
      @projects = current_user.my_projects
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    session[:current_project_id] = current_project.id || nil
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
    @user = User.find_by_username(params[:email])
    @collaborator = Collaborator.new(:user_id => @user.id, :role => params[:role])
    current_project.collaborators << @collaborator
    @collaborator.new_activity(@collaborator.project.id, current_user.id,'created')
    respond_to do |format|
      format.js { render :add_collaborator }
    end
  end

  def remove_collaborator
    collaborator = current_project.collaborators.find(params[:user])
    if current_user.is_admin_or_owner?(current_project) || collaborator.user == current_user
      @id = collaborator.id
      if collaborator
        @i_am_out = true if current_user == collaborator.user
        collaborator.destroy
        @text ="Se elimino el colaborador"
        @result = true
      else
        @text ="No se pudo encontrar el colaborador"
        @result = false
      end

    else
      @text = "You can't delete users if you are not admin or owner"
      @result = false
    end
    respond_to do |format|
      format.js {render :remove_collaborator}
    end
  end

  def update_collaborator
    id ||= params[:id].split('_')[1] if params[:id]
    @collaborator = Collaborator.find(id)
    if @collaborator.update_field('role',params[:value])
      @collaborator.new_activity(@collaborator.project.id, current_user.id,'updated')
      text = "Collaborator #{@collaborator.user.username} was successfully updated"
    else
      text = "Sorry, we couldn't do it..."
    end
    render :text => @collaborator.role
  end
  def get_users
    @users = User.where('username LIKE ?', "%" + params[:term] + "%") - current_project.collaborators.collect(&:user)
    respond_to do |format|
      format.js {render :json => @users.collect{|u| [:id => u.id, :label => u.username, :value => u.username ]}.flatten! }
    end
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

