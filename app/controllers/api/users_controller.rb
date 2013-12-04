class Api::UsersController < Api::BaseController
  before_action :set_user, only: :show

  def show
    render json: @user
  end

  private

  def set_user
    @user = User.find_by_username(params[:id])
  end
end
