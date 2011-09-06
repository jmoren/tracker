class TasksController < ApplicationController
  def index
    @task_list = TaskList.find(params[:task_list_id])
    @created = Task.by_status('created', @task_list)
    @in_progress = Task.by_status('progress', @task_list)
    @commited = Task.by_status('commited', @task_list)
    @testing = Task.by_status('testing', @task_list)
    @aproved = Task.by_status('aproved', @task_list)
    @merged = Task.by_status('merged', @task_list)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
  end

  def create
    @task = Task.new(params[:task])
    @task_list = TaskList.find(params[:task_list_id])
    @task.user = current_user
    if @task.save
      respond_to do |format|
        format.html { redirect_to @task.task_list, :notice => "Successfully created task." }
        format.js
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to @task, :notice  => "Successfully updated task."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @id = @task.id
    @task_list = @task.task_list
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @task_list, :notice => "Successfully destroyed task." }
      format.js
    end
  end

  def move_status
    @task = Task.find(params[:id])
    @task_list = @task.task_list
    st = @task.update_status(params[:status])
    @tasks = Task.by_status(params[:status],@task_list)
    respond_to do |format|
      format.js { render 'move_status' }
    end
  end
end

