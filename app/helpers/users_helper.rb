module UsersHelper
  def get_users()
    @users = User.order(:id).page(params[:page]).per(12)
  end
end
