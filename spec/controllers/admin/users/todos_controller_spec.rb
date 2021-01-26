require 'rails_helper'

RSpec.describe Admin::Users::TodosController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:manager) { FactoryBot.create(:user, role: :manager) }
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let!(:todo) { FactoryBot.create(:todo, user: user) }
  let!(:todo2) { FactoryBot.create(:todo, user: manager) }

  describe 'GET #index' do
    it 'allows admin to receive todos list' do
      sign_in_as(admin)
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq todo.id
    end

    it 'allows manager to receive users list' do
      sign_in_as(manager)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(403)
    end

    it 'does not allow regular user to receive users list' do
      sign_in_as(user)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(403)
    end
  end
end
