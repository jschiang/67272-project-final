class HomeController < ApplicationController
  def index
    if logged_in?
      # get my dojo
      @student = current_user.student
      @registrations = @student.registrations.by_event_name.paginate(:page => params[:page]).per_page(10)
      @dojo = @student.current_dojo
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
  end
end
