# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_up
   #def new
     #super
   #end

  # POST /resource
   #def create
     #super
   #end

  # GET /resource/edit
  # PUT /resource
   #def update
     #super
   #end

  # DELETE /resource
   #def destroy
     #super
   #end
   
  def show
    
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
