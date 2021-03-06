class DojosController < ApplicationController

  before_filter :check_login, :except => [:index, :show]

  def index
    @dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @dojo = Dojo.find(params[:id])
    @dojo_students = @dojo.dojo_students.current.paginate(:page => params[:page]).per_page(15)
    @dojo_student = DojoStudent.new
  end
  
  def new
    @dojo = Dojo.new
    authorize! :new, @dojo
  end

  def edit
    @dojo = Dojo.find(params[:id])
    authorize! :edit, @dojo
  end

  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      # if saved to database
      flash[:notice] = "Successfully created #{@dojo.name} dojo."
      redirect_to @dojo # go to show dojo page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name} dojo."
      redirect_to @dojo
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    authorize! :destroy, @dojo
    @dojo.destroy
    flash[:notice] = "Successfully removed #{@dojo.name} from karate tournament system"
    redirect_to dojos_url
  end
end