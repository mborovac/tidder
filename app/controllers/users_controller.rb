class UsersController < ApplicationController

  def settings
    @user = User.find(current_user.id)
    @name = "Settings"
    @disabled = true
    @frontpage = true
    @subscribed_subreddits = current_user.subreddits
    @settings = true
  end

  def update_settings
    @user = current_user
    flash[:alert] = 'File type is not allowed (only jpeg/png/gif images)' if not @user.update(user_params)
    redirect_to settings_users_path
  end

  private

  def user_params
    params.require(:user).permit(:gender, :avatar, :nickname)
  end

end
