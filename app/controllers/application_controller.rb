class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized
  protect_from_forgery with: :exception
end
