class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password ])
		devise_parameter_sanitizer.permit(:edit, keys: [ :username, :email, :password, :current_password, :street, :city, :country, :photo ])
	end
end
