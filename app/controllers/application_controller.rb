class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate!
    auth_result = authenticate_with_http_basic do |_, password|
      authenticate_with_config(password)
    end
    session[:authenticated] = auth_result
    request_http_basic_authentication unless auth_result
  end

  private

  def authenticate_with_config(pass)
    auth = Rails.application.secrets.try(:auth)
    return false if auth.nil?
    ActiveSupport::SecurityUtils.secure_compare(
      ::Digest::SHA256.hexdigest(auth),
      ::Digest::SHA256.hexdigest(pass)
    )
  end
end
