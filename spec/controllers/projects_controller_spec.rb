require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end


end
