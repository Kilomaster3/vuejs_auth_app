require 'rails_helper'

RSpec.deprecate SigninController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:user_params) { { email: user.email, password: password } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to have_http_status(200)
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post :create, params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(401)
    end
  end
end
