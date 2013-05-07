class TournamentsController < ApplicationController

  before_filter :check_login

  def index
    @tournaments = Tournament.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @tournament = Tournament.find(params[:id])
    @sections = @tournament.sections.paginate(:page => params[:page]).per_page(7)
  end
  
  def new
    @tournament = Tournament.new
    authorize! :new, @tournament
  end

  def edit
    @tournament = Tournament.find(params[:id])
    authorize! :edit, @tournament
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      # if saved to database
      flash[:notice] = "Successfully created #{@tournament.name} tournament."
      redirect_to @tournament # go to show tournament page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Successfully updated #{@tournament.name} tournament."
      redirect_to @tournament
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    authorize! :destroy, @tournament
    @tournament.destroy
    flash[:notice] = "Successfully removed #{@tournament.name} from karate tournament system"
    redirect_to tournaments_url
  end
end