require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do

  describe "GET index" do
    context "when unauthorized request" do
      before { get :index }
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      let!(:categories) { create_list(:category, 10) }

      before(:each) do
        user = create(:user)
        authorize(user)
        get :index, as: :json
      end

      it "responds with 200 code" do
        expect(response.status).to eq 200
      end

      it "returns all of the categories" do
        categories_json = JSON.parse(response.body)["data"]
        expect(categories_json.size).to eq categories.size
      end
    end
  end

  describe "GET show" do
    context "when unauthorized request" do
      before { get :show, params: { id: 1 }}
      include_examples "unauthorized_request"
    end

    context "when authorized request" do
      let!(:categories) { create_list(:category, 10) }
      let(:category) { categories.sample }

      context "with existing category" do
        before(:each) do
          user = create(:user)
          authorize(user)
          get :show, params: { id: category.id }, as: :json
        end

        it "responds with 200 code" do
          expect(response.status).to eq 200
        end

        it "returns the category" do
          categories_json = JSON.parse(response.body)["data"]
          expect(categories_json["id"]).to eq category.id.to_s
        end
      end

      context "with unexisting category" do
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
        post :create, params: { category: { name: "test", description: "test "} }, as: :json
      end
      it "responds with 201 code" do
        expect(response.status).to eq 201
      end
      it "creates the category" do
        categories_json = JSON.parse(response.body)["data"]
        expect(categories_json['attributes']["name"]).to eq "test"
      end
    end
  end

  describe "PATCH update" do
    context "when unauthorized request" do
      before { patch :update, params: { id: 1 }}
      include_examples "unauthorized_request"
    end
    context "when authorized request" do
      let!(:categories) { create_list(:category, 10) }
      let(:category) { categories.sample }

      before(:each) do
        user = create(:user)
        authorize(user)
        patch :update, params: { id: category.id, category: { name: "test", description: "test "} }, as: :json
      end
      it "responds with 200 code" do
        expect(response.status).to eq 200
      end
      it "updates the category" do
        categories_json = JSON.parse(response.body)["data"]
        expect(categories_json['attributes']["name"]).to eq "test"
      end
    end
  end

  describe "DELETE destroy" do
    context "when unauthorized request" do
      before { delete :destroy, params: { id: 1 }}
      include_examples "unauthorized_request"
    end
    context "when authorized request" do
      let!(:categories) { create_list(:category, 10) }
      let(:category) { categories.sample }

      before(:each) do
        user = create(:user)
        authorize(user)
        delete :destroy, params: { id: category.id }, as: :json
      end
      it "responds with 200 code" do
        expect(response.status).to eq 200
      end
      it "destroys the category" do
        expect(Category.exists?(category.id)).to be false
      end
    end
  end

end
