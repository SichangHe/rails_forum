class UsersController < ApplicationController
  before_action :set_user, except: %i[edit_info update_info]

  # GET /users/edit_info
  def edit_info; end

  # PATCH /users/update_info
  def update_info
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user.path, notice: 'User info successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/:id
  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
