class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email_id, subject: 'Welcome to My Awesome Site')
  end

  def reset_password(user)
    @user = user
    mail(to: @user.email_id, subject: 'Reset your password')
  end
end
