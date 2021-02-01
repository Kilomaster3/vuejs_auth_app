class UserMailer < ApplicationMailer
  def reset_password(user)
    @user = user[:params]
    mail(to: @user.email, subject: 'Reset your password')
  end
end
