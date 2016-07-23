class StaticController < ApplicationController
  def index
    skip_authorization
  end
end
