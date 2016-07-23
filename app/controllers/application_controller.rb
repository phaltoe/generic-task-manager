class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index
  protect_from_forgery with: :exception
end
