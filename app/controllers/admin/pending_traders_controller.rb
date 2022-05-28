class Admin::PendingTradersController < ApplicationController
  def index
    @users = User.where(approved: false, role: :trader)
    render json: @users
  end

  def update
    @user = User.find params[:id]

    if @user.update(approved: true)
      render(json: { 'message': 'Successfully approved user!', 'status': 200 },
             status: 200)
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to admin_pending_traders_path, notice: 'User approved.'
    else
      render :index
    end
  end
end
