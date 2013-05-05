class UsersController < ApplicationController
  
  
  def index
  end

  def show
  end

  def new
    @user = User.new
    authorize! :new, @user
    @user.student_id = params[:student_id] unless params[:student_id].nil?
  end

  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
      if params[:from] == 'student'
        redirect_to student_path(@user.student)
      else
        redirect_to students_path
      end
  end

  def create
    @user = User.new(params[:user])
    authorize! :create, @user
    @user.created_by = current_user.id
    if @user.save
      # if saved to database
      flash[:notice] = "Account for #{@user.student.proper_name} has been created."
      redirect_to student_path(@user.student)
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    authorize! :update, @task
    
    if @task.save!
      flash[:notice] = "Account for #{@user.student.proper_name} has been updated."
      redirect_to student_path(@user.student)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy
    flash[:notice] = "Successfully removed account for #{@user.student.proper_name}."
    redirect_to students_url
  end

end
