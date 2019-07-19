class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_sign_up_params ,if: :devise_controller?

    layout :layout_by_resource


    private
    def layout_by_resource
        if devise_controller?
            "devise"
        else
            "application"
        end
    end

    protected

# If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :setor])
   end

end
