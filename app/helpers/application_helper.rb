module ApplicationHelper
  def authenticated?
    session[:authenticated] && session[:authenticated] == true
  end
end
