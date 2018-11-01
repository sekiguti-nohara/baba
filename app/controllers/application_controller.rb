class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
		session[:room_id] = []
		root_path
	end


	protected

  def configure_permitted_parameters
    added_attrs = [ :name ]
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
