require 'rails_helper'

RSpec.describe "Refreshes", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/refresh/create"
      expect(response).to have_http_status(:success)
    end
  end

end
