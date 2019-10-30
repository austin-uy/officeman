module UsersHelper
  def getter_users
    @users = User.order(:id).page(params[:page]).per(12)
  end
end
