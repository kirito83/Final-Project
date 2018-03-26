class UserMailer < ApplicationMailer
  def welcome_email(email)
     mail(from: "calvin8313@hotmail.fr", to: email,
          subject: "Bienvenue !")
  end
end
