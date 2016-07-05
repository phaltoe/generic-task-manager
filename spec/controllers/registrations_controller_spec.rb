require_relative '../rails_helper' 

describe RegistrationsController do
  include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  describe 'GET #new' do
    it "renders the :new Template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new user and profile in the database" do
        profile_attrs = FactoryGirl.attributes_for(:profile)
        user_attrs = FactoryGirl.attributes_for(:user).merge({:profile_attributes => profile_attrs})
        expect{
          post :create, user: user_attrs
        }.to change(User, :count).by(1)
      end

      it "saves the new profile for the user" do
        profile_attrs = FactoryGirl.attributes_for(:profile)
        user_attrs = FactoryGirl.attributes_for(:user).merge({:profile_attributes => profile_attrs})
        expect{
          post :create, user: user_attrs
        }.to change(Profile, :count).by(1)
      end

      it "redirects to site root"
    end

    context "without valid attributes" do
      it "does not save the new user and profile in the database"
      it "re-renders the :new template"
    end
  end

  describe 'PUT #edit' do
    before :each do
      @profile = FactoryGirl.create(:profile)
      @user = FactoryGirl.create(:user, :profile => @profile)
      sign_in @user
    end

    it 'does not update username field' do
      patch :update, id: @user, user: {:current_password => @user.password}.merge({:profile_attributes => attributes_for(:profile, id: @profile.id, username: 'newusername')})
      expect(@user.username).not_to eq('newusername')
    end

    it 'does update the website field' do
      patch :update, id: @user, user: {:current_password => @user.password}.merge({:profile_attributes => attributes_for(:profile, id: @profile.id, website: 'http://my-new-site.org')})
      @user.reload
      @profile.reload
      expect(@user.website).to eq('http://my-new-site.org')
    end
  end
end
