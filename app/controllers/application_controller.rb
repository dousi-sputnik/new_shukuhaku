class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :configure_permitted_parameters , if: :devise_controller?
  before_action :set_q_for_room

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def set_q_for_room
    @q_header = Room.ransack(params[:q])
  end
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_image])
  end
end
