# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :set_user, only: %i(edit update)

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user.id), notice: 'User updated successfully!'
    else
      flash_alerts(@user)
      render 'edit', user: @user.id
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def authorize!; end
end
