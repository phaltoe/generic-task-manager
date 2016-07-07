require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include Devise::TestHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    it "renders the :new template" do
      user = FactoryGirl.create(:user)
      sign_in user
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.build(:project) }

    context 'with valid attributes' do
      it 'is valid with user_id' do
        expect(project).to be_valid
      end

      it 'is invalid without a user_id' do
        project.owner = nil
        expect(project).to_not be_valid
      end

      it 'saves the new project' do
        sign_in user
        project_attrs = attributes_for(:project, :user_id => user.id)
        expect {
          post :create, project: project_attrs
        }.to change(Project, :count).by(1)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project, :owner => user) }

    it 'user can update their project and save it' do
      sign_in user
      patch :update, id: project.id, project: { :title => 'My new title' }
      project.reload
      expect(project.title).to eq("My new title")
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:project) { FactoryGirl.create(:project, :owner => user) }

    it 'deletes the project' do
      sign_in user
      expect{
        delete :destroy, id: project
      }.to change(Project, :count).by(-1)
    end
  end
end
