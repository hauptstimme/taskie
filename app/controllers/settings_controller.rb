class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to settings_path, notice: "Settings were successfully updated."
    else
      render "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:time_zone)
  end
end
