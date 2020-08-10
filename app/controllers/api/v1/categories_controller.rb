module Api
  module V1
    class CategoriesController < ApplicationController

      before_action :authenticate_user!

      def index
        render json: serialize(Category.all)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def show
        @category = Category.find(params[:id])
        render json: serialize(@category)
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          render json: serialize(@category), status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      rescue ActionController::ParameterMissing => ex
        respond_to_missing_params_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          render json: serialize(@category), status: :ok
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      rescue ActionController::ParameterMissing => ex
        respond_to_missing_params_error(ex)
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def destroy
        @category = Category.find(params[:id])
        @category.destroy
        render json: {}, status: :ok
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      private

      def serialize(categories)
        CategorySerializer.new(categories, include: [:techs])
      end

      def category_params
        params.require(:category).permit(:name, :description)
      end
    end
  end
end
