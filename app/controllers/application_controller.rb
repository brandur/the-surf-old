class ApplicationController < ActionController::Base
  layout :set_layout
  protect_from_forgery

  protected

  def authorized?
    authenticate_with_http_basic do |username, password|
      password == App.http_auth_key
    end
  end

  def authorized!
    head(401) unless authorized?
  end

  private

  def pjax?
    request.headers['X-PJAX'] ? true : false
  end

  def set_layout
    if pjax?
      false
    else
      "application"
    end
  end
end
