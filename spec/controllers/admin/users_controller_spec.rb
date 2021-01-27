require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:manager) { FactoryBot.create(:user, role: :manager) }
  let!(:admin) { FactoryBot.create(:user, role: :admin) }

  describe 'GET #index' do
    it 'allows admin to receive users list' do
      sign_in_as(admin)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 3
    end

    it 'allows manager to receive users list' do
      sign_in_as(manager)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 3
    end

    it 'does not allow regular user to receive users list' do
      sign_in_as(user)
      get :index
      expect(response).to have_http_status(403)
    end
  end
end
