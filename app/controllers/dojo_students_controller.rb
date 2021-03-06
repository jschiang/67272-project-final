class DojoStudentsController < ApplicationController

  def index
    @dojo_students = DojoStudent.by_student.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @dojo_student = DojoStudent.find(params[:id])
  end
  
  def new
    @dojo_student = DojoStudent.new
  end

  def edit
    @dojo_student = DojoStudent.find(params[:id])
  end

  def create
    @dojo_student = DojoStudent.new(params[:dojo_student])
    @dojo_student.start_date = Date.today
    if @dojo_student.save!
      # if saved to database
      flash[:notice] = "Successfully created dojo_student for #{@dojo_student.student.proper_name}."
      redirect_to dojo_path(@dojo_student.dojo_id) # go to show dojo page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @dojo_student = DojoStudent.find(params[:id])
    if @dojo_student.update_attributes(params[:dojo_students])
      flash[:notice] = "Successfully updated dojo_students for #{@dojo_student.student.proper_name}."
      redirect_to @dojo_students
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo_student = DojoStudent.find(params[:id])
    dojo_id = @dojo_student.dojo.id
    @dojo_student.destroy
    flash[:notice] = "Successfully removed dojo_student for #{@dojo_student.student.proper_name} from karate tournament system"
    # redirect_to dojo_students_url
    redirect_to dojo_path(dojo_id) # go to show dojo page
  end
end