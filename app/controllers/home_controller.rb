class HomeController < ApplicationController
  def index
  end

   def send_email
    if signed_in?
      UserMailer.welcome_email(current_user.email).deliver_now!
      flash[:success] = 'Vous venez de recevoir un email'
      redirect_to root_path
    else
      flash[:danger] = 'Connectez vous ou enregistrez vous en bas de page pour recevoir des emails'
      redirect_to '/users/sign_in'
    end
  end
end
