require 'rails_helper'

RSpec.describe HomepageController, type: :controller do

  describe "GET index" do
    context "when unauthorized request" do
      before { get :index }
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      it "responds with 200 code" do
        user = create(:user)
        authorize(user)
        get :index, as: :json
        expect(response.status).to eq 204
      end

    end
  end

end
