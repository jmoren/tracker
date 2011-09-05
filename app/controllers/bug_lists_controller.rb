class BugListsController < ApplicationController
  def index
    @bug_lists = BugList.all
  end

  def show
    @bug_list = BugList.find(params[:id])
  end

  def new
    @bug_list = BugList.new
  end

  def create
    @bug_list = BugList.new(params[:bug_list])
    if @bug_list.save
      redirect_to @bug_list, :notice => "Successfully created bug list."
    else
      render :action => 'new'
    end
  end

  def edit
    @bug_list = BugList.find(params[:id])
  end

  def update
    @bug_list = BugList.find(params[:id])
    if @bug_list.update_attributes(params[:bug_list])
      redirect_to @bug_list, :notice  => "Successfully updated bug list."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bug_list = BugList.find(params[:id])
    @bug_list.destroy
    redirect_to bug_lists_url, :notice => "Successfully destroyed bug list."
  end
end
