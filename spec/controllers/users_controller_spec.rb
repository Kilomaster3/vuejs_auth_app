require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:todo) { FactoryBot.create(:todo, user: user) }

  describe 'GET#me' do

    before do
      sign_in_as(resource)
      get :me
    end

    context 'user' do
      let(:resource) { user }

      it 'returns a success response' do
        expect(response).to be_successful
        expect(response_json).to eq user.as_json(only: %i[id email role])
      end
    end
  end
end
