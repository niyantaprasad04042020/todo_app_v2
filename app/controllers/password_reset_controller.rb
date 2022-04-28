class PasswordResetController < ApplicationController

	before_action :set_user, only: [:edit]
  
  def create
    user = User.find_by(email_id: password_reset_params[:email_id])
    if user
      user.generate_token_for_password_reset!
      UserMailer.reset_password(user).deliver_now
      render json: {status: 'Reset mail send successfully'}, status: :ok
    end
  end

  def edit
    render json: :ok
  end

  def update
    @user.update!(password_reset_params)
    @user.clear_password_token!
    render json: :ok
  end

  private

  def set_user
  	unless @user && @user.reset_password_token_expires_at && @user.reset_password_token_expires_at > Time.now
      @user = User.find_by(reset_password_token: params[:token])
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:email_id, :password, :password_confirmation)
  end
end
