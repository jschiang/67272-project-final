class HomeController < ApplicationController
  def index
    if logged_in?
      # get my dojo
      @registrations = current_user.student.registrations
      
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
