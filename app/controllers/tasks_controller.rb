class TasksController < ApplicationController
  def index
    @task_list = TaskList.find(params[:task_list_id])
    @todo = Task.by_state(1, @task_list)
    @progress = Task.by_state(2, @task_list)
    @merged = Task.by_state(3, @task_list)
  end

  def show
    @task = Task.find(params[:id])
    render :layout => false
  end

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
  end

  def create
    @task = Task.new(params[:task])
    @task_list = TaskList.find(params[:task_list_id])
    @task.user = current_user
    @task.state = 1
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
  def add_comments
    @task = Task.find(params[:id])
    @comment = Comment.new(:user_id => current_user.id, :body => params[:body], :task_id => @task.id)
    if @comment.save
      @task.reload
      render :add_comments
    end
    
  end
  def remove_comments
    @task = Task.find(params[:id])
    @comment = @task.comments.find(params[:comment])
    @id = @comment.id
    @comment.destroy
  end
  def move_state
    @task = Task.find(params[:id])
    @task_list = @task.task_list
    

    @old_state = @task.state
    @old_dom = @old_state == 1 ? '#todo' : @old_state == 2 ? '#progress' : '#done'
    #after update:
    @task.update_state(params[:state])
    @state = @task.state
    @dom = params[:state] == '1' ? '#todo' : params[:state] == '2' ? '#progress' : '#done'
    
    @old_tasks = Task.by_state(@old_state, @task_list)
    @tasks = Task.by_state(params[:state],@task_list)
  end
end

