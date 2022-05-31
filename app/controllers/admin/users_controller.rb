class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.where(role: :trader)
    render json: @users
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    @user.confirmed_at = Time.now

    if @user.save
      render(json: { 'message': 'Account saved', 'status': 200 },
             status: 200)

    else
      error = @user.errors.full_messages
      render json: error
    end
  end

  def edit; end

  def update
    if @user.update(allowed_params)
      render json: @user

    else
      error = @user.errors.full_messages
      render json: error
    end
  end

  def destroy
    @user.destroy
    render json: @user.destroy
  end

  private

  def allowed_params
    params.require(:user).permit(:email, :password, :approved)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find params[:id]
  end
end
