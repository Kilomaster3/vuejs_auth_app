require 'rails_helper'

RSpec.describe SigninController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:user_params) { { email: user.email, password: '123456789a' } }

    it 'returns unauthorized for invalid params' do
      post :create, params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(401)
    end
  end
end
