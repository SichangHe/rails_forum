class UsersController < ApplicationController
  before_action :set_user, except: %i[edit_info]

  # GET /users/edit_info
  def edit_info; end

  # GET /users/:id
  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
