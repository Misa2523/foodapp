class Public::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller? #deviseコントローラ実行前のsign_up時にnameなども受け取る

  def after_sign_up_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :telephone_number])
  end

end
