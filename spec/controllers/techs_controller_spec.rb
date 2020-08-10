require 'rails_helper'

RSpec.describe Api::V1::TechsController, type: :controller do

  describe "GET index" do
    context "when unauthorized request" do
      before { get :index }
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      let!(:techs) { create_list(:tech, 10) }

      before(:each) do
        user = create(:user)
        authorize(user)
        get :index, as: :json
      end

      it "responds with 200 code" do
        expect(response.status).to eq 200
      end

      it "returns all of the techs" do
        techs_json = JSON.parse(response.body)["data"]
        expect(techs_json.size).to eq techs.size
      end
    end
  end

  describe "GET show" do
    context "when unauthorized request" do
      before { get :show, params: { id: 1 }}
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      let!(:techs) { create_list(:tech, 10) }
      let(:tech) { techs.sample }

      context "with existing tech" do
        before(:each) do
          user = create(:user)
          authorize(user)
          get :show, params: { id: tech.id }, as: :json
        end

        it "responds with 200 code" do
          expect(response.status).to eq 200
        end

        it "returns the tech" do
          techs_json = JSON.parse(response.body)["data"]
          expect(techs_json["id"]).to eq tech.id.to_s
        end
      end

      context "with unexisting tech" do
        before(:each) do
          user = create(:user)
          authorize(user)
          get :show, params: { id: 100000 }, as: :json
        end

        it "responds with 404 code" do
          expect(response.status).to eq 404
        end

      end

    end
  end

  describe "POST create" do
    context "when unauthorized request" do
      before { post :create, params: { id: 1 }}
      include_examples "unauthorized_request"
    end
    context "when authorized request" do
      before(:each) do
        user = create(:user)
        authorize(user)
        post :create, params: { tech: { name: "test", description: "test "} }, as: :json
      end
      it "responds with 201 code" do
        expect(response.status).to eq 201
      end
      it "creates the tech" do
        techs_json = JSON.parse(response.body)["data"]
        expect(techs_json['attributes']["name"]).to eq "test"
      end
    end
  end

  describe "PATCH update" do
    context "when unauthorized request" do
      before { patch :update, params: { id: 1 }}
      include_examples "unauthorized_request"
    end
    context "when authorized request" do
      let!(:techs) { create_list(:tech, 10) }
      let(:tech) { techs.sample }

      before(:each) do
        user = create(:user)
        authorize(user)
        patch :update, params: { id: tech.id, tech: { name: "test", description: "test "} }, as: :json
      end
      it "responds with 200 code" do
        expect(response.status).to eq 200
      end
      it "updates the tech" do
        techs_json = JSON.parse(response.body)["data"]
        expect(techs_json['attributes']["name"]).to eq "test"
      end
    end
  end

  describe "DELETE destroy" do
    context "when unauthorized request" do
      before { delete :destroy, params: { id: 1 }}
      include_examples "unauthorized_request"
    end
    context "when authorized request" do
      let!(:techs) { create_list(:tech, 10) }
      let(:tech) { techs.sample }

      before(:each) do
        user = create(:user)
        authorize(user)
        delete :destroy, params: { id: tech.id }, as: :json
      end
      it "responds with 200 code" do
        expect(response.status).to eq 200
      end
      it "destroys the tech" do
        expect(Tech.exists?(tech.id)).to be false
      end
    end
  end

end
