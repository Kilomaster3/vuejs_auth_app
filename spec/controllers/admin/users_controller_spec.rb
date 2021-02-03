require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:manager) { FactoryBot.create(:user, role: :manager) }
  let!(:admin) { FactoryBot.create(:user, role: :admin) }

  describe 'GET #index' do
    before do
      sign_in_as(resource)
      get :index
    end

    context 'admin' do
      let(:resource) { admin }

      it 'allows admin to receive users list' do
        expect(response).to be_successful
        expect(response_json.size).to eq 3
      end
    end

    context 'manager' do
      let(:resource) { manager }

      it 'allows manager to receive users list' do
        expect(response).to be_successful
        expect(response_json.size).to eq 3
      end
    end

    context 'user' do
      let(:resource) { user }

      it 'does not allow regular user to receive users list' do
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'GET#show' do
    before do
      sign_in_as(resource)
      get :show, params: { id: user.id }
    end

    context 'admin' do
      let(:resource) { admin }

      it 'allows admin to get a user' do
        expect(response).to be_successful
      end
    end

    context 'manager' do
      let(:resource) { manager }

      it 'allows manager to get a user' do
        expect(response).to be_successful
      end
    end

    context 'user' do
      let(:resource) { user }

      it 'does not allow regular user to get a user' do
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'PATCH#update' do

    before do
      sign_in_as(resource)
      patch :update, params: { id: user.id, user: { role: :manager } }
    end

    context 'admin' do
      let(:resource) { admin }

      it 'allows admin to update a user' do
        expect(response).to be_successful
        expect(user.reload.role).to eq 'manager'
      end

      it 'does not allow admin to update their own role' do
        patch :update, params: { id: admin.id, user: { role: :manager } }
        expect(response).to have_http_status(400)
      end
    end

    context 'manager' do
      let(:resource) { manager }

      it 'does not allow manager to update a user' do
        expect(response).to have_http_status(403)
      end
    end

    context 'user' do
      let(:resource) { user }

      it 'does not allow user to update a user' do
        expect(response).to have_http_status(403)
      end
    end
  end
end
