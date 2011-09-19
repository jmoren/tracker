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
    @dom = @task.state == 1 ? '#todo' : @task.state == 2 ? '#progress' : '#done'
    @state = @task.state
    @tasks = Task.by_state(@task.state, @task.task_list)
    @task.destroy
    respond_to do |format|
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
    # find objects
    @task = Task.find(params[:id])
    @task_list = @task.task_list
    
    #save information
    @old_state = @task.state
    @old_dom = @old_state == 1 ? '#todo' : @old_state == 2 ? '#progress' : '#done'
    
    #update:
    @task.update_state(params[:state])
    
    #save new information
    @state = @task.state
    @dom = params[:state] == '1' ? '#todo' : params[:state] == '2' ? '#progress' : '#done'
    
    #update lists
    @old_tasks = Task.by_state(@old_state, @task_list)
    @tasks = Task.by_state(@state, @task_list)
  end

  def update_in_place
    if params[:id]
      p = params[:id].split('_')
      field,id = p[0],p[1]
      if field == 'assigned'
        value = User.find_by_username(params[:value])
      else
        value = params[:value]
      end
      @task = Task.find(id)
      @task.update_field(field, value)
      if field == 'assigned'
        msg = @task.assigned.username
      else
        msg = @task.send(field)
      end
      render :text => msg
    end
  end
  def update_task
    @task = Task.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

end

