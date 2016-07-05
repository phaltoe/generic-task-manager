class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    super do |resource|
      resource.build_profile
    end
  end

  def destroy
    resource.update(active: false)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  protected

  def after_sign_up_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_attributes => [:username, :website]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_attributes => [:website, :id]])
  end
end
