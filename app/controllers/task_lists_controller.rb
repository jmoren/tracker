class TaskListsController < ApplicationController
  def index
    @task_lists = TaskList.all
  end

  def show
    @task_list = TaskList.find(params[:id])
    @tasks = @task_list.tasks
    @collaborators = @task_list.project.all_members
  end

  def new
    @task_list = TaskList.new
    @project = Project.find(params[:project_id])
  end

  def create
    @task_list = TaskList.new(params[:task_list])
    @task_list.user = current_user
    if @task_list.save
      redirect_to @task_list, :notice => "Successfully created task list."
    else
      render :action => 'new'
    end
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def update
    @task_list = TaskList.find(params[:id])
    add_user = {}
    if @task_list.user.nil?; add_user = { :user_id => current_user.id };end 
    if @task_list.update_attributes(params[:task_list].merge(add_user))
      redirect_to @task_list, :notice  => "Successfully updated task list."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task_list = TaskList.find(params[:id])
    @project = @task_list.project
    @task_list.destroy
    redirect_to project_path(@project,:anchor => 'tasks'), :notice => "Successfully destroyed task list."
  end
end
