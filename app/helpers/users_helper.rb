module UsersHelper

  def user_is_login?
    session[:session].present?
  end

  def current_user
    @current_user ||= User.find(session[:session])
  end

end
