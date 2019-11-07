class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin, only: %i[index create destroy]
  before_action :set_user, only: %i[edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    redirect_to users_url(open: true)
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      format.html { redirect_to users_url(open: false) }
      format.js
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render json: { message: 'OK' }, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end

    respond_to do |format|
      if @user.update(user_params)
        bypass_sign_in(@user) if  params[:user][:edit_profile].present? &&
                                  params[:user][:password].present?
        format.json { render json: { message: 'OK' }, status: :ok }
      else
        format.json {
          render json: @user.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User deleted.' }
      format.json { head :no_content }
    end
  end

  # PUT /validate
  def validate
    respond_to do |format|
      case params[:type]
      when 'email'
        format.json do
                      render json: {
                        exists: User.where(email: params[:email])
                        .where.not(id: params[:id]).exists?
                      },
                      status: :ok
                    end
      when 'password'
        format.json do
                      render json: {
                        validate: User.find(params[:id])
                        .valid_password?(params[:password])
                      },
                      status: :ok
                    end
      else
        format.json do
                      render json: {
                        message: 'Bad Request'
                      },
                      status: :bad_request
                    end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to users_url, notice: 'Record not found.'
  end

  # Never trust parameters from the scary internet, only allow the
  # white list through.
  def user_params
    params.require(:user).permit(
      :name, :role, :picture,
      :email, :password,
      :password_confirmation)
  end

  def authenticate_admin
    # TODO; Add authentication logic here.
    redirect_to home_path, notice: 'Access denied.' unless current_user.admin?
  end
end
