require 'rails_helper'

RSpec.describe Admin::Users::TodosController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:manager) { FactoryBot.create(:user, role: :manager) }
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let!(:todo) { FactoryBot.create(:todo, user: user) }
  let!(:todo2) { FactoryBot.create(:todo, user: manager) }

  describe 'GET #index' do

    before do
      sign_in_as(resource)
      get :index, params: { user_id: user.id }
    end

    context 'admin' do
      let(:resource) { admin }

      it 'allows admin to receive todos list' do
        expect(response).to be_successful
        expect(response_json.size).to eq 1
        expect(response_json.first['id']).to eq todo.id
      end
    end

    context 'manager' do
      let(:resource) { manager }

      it 'allows manager to receive users list' do
        expect(response).to have_http_status(403)
      end
    end

    context 'user' do
      let(:resource) { user }

      it 'does not allow regular user to receive users list' do
        expect(response).to have_http_status(403)
      end
    end
  end
end
