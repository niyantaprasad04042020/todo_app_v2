class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email_id, subject: 'Welcome to My Awesome Site')
  end
end
