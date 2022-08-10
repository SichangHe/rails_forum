class HomeController < ApplicationController
  # GET '/', redirect to user show page if logged in, else to posts
  def index
    redirect_to(current_user&.path || posts_path)
  end
end
