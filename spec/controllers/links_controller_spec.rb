require 'rails_helper'

RSpec.describe Api::V1::LinksController do
  describe "GET index" do
    context "when unauthorized request" do
      before { get :index }
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      let!(:links) { create_list(:link, 10) }

      before(:each) do
        user = create(:user)
        authorize(user)
        get :index, as: :json
      end

      it "responds with 200 code" do
        expect(response.status).to eq 200
      end

      it "returns all of the links" do
        links_json = JSON.parse(response.body)["data"]
        expect(links_json.size).to eq links.size
      end
    end
  end

  describe "GET show" do
    context "when unauthorized request" do
      before { get :show, params: { id: 1 }}
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      let!(:links) { create_list(:link, 10) }
      let(:link) { links.sample }

      context "with existing link" do
        before(:each) do
          user = create(:user)
          authorize(user)
          get :show, params: { id: link.id }, as: :json
        end

        it "responds with 200 code" do
          expect(response.status).to eq 200
        end

        it "returns the link" do
          links_json = JSON.parse(response.body)["data"]
          expect(links_json["id"]).to eq link.id.to_s
        end
      end

      context "with unexisting link" do
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
      context "with an unexisting link" do
        let(:category) { create(:category) }
        let(:tech) { create(:tech) }

        before(:each) do
          user = create(:user)
          authorize(user)
          post :create, params: { link: { category_id: category.id, tech_id: tech.id} }, as: :json
        end
        it "responds with 201 code" do
          expect(response.status).to eq 201
        end
        it "creates the link" do
          links_json = JSON.parse(response.body)["data"]
          expect(links_json['attributes']["category_id"]).to eq category.id
          expect(links_json['attributes']["tech_id"]).to eq tech.id
        end
      end
      context "with an existing link" do
        let(:link) { create(:link) }
        before(:each) do
          user = create(:user)
          authorize(user)
          post :create, params: { link: { category_id: link.category.id, tech_id: link.tech.id} }, as: :json
        end
        it "responds with 409 code" do
          expect(response.status).to eq 409
        end
        it "cannot create duplicate links" do
          links_json = JSON.parse(response.body)["msg"]
          expect(links_json).to eq "Resource already exists"
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when unauthorized request" do
      before { delete :destroy, params: { id: 1 }}
      include_examples "unauthorized_request"
    end
    context "when authorized request" do
      let!(:links) { create_list(:link, 10) }
      let(:link) { links.sample }

      before(:each) do
        user = create(:user)
        authorize(user)
        delete :destroy, params: { id: link.id }, as: :json
      end
      it "responds with 200 code" do
        expect(response.status).to eq 200
      end
      it "destroys the link" do
        expect(Link.exists?(link.id)).to be false
      end
    end
  end
end
