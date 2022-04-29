class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def signup
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      UserMailer.welcome_email(@user).deliver_now
      token = encode_token({user_id: @user.id})
      redirect_to login_path
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def new 
  end

  def login
    @user = User.find_by(email_id: user_params[:email_id])

    if @user && @user.authenticate(user_params[:password])
      if user.confirmed_at?
        token = encode_token({user_id: @user.id})
        redirect_to root_path
      else
        render json: {error: 'Email not verified' }, status: :unauthorized
      end
    else
      render json: {error: "Invalid username or password"}
    end
  end


  def auto_login
    render json: @user
  end

  def confirm
    token = params[:token].to_s

    user = User.find_by(confirmation_token: token)

    if user.present? && user.mark_as_confirmed!
      render json: {status: 'User confirmed successfully'}, status: :ok
    else
      render json: {status: 'Invalid token'}, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_id, :phone_no, :password, :authenticity_token)
  end

end
