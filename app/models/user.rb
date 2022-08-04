class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def path
    "/users/#{id}"
  end

  def edit_info_path
    '/users/edit_info'
  end

  def edit_path
    '/users/edit'
  end
end
