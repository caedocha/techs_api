module Api
  module V1
    class LinksController < ApplicationController

      before_action :authenticate_user!

      def index
        render json: serialize(Link.all)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def show
        link = Link .find(params[:id])
        render json: serialize(link)
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def create
        category = Category.find(link_params[:category_id])
        tech = Tech.find(link_params[:tech_id])
        link = Link.new(category: category, tech: tech)
        if link.save
          render json: serialize(link), status: :created
        else
          render json: link.errors, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotUnique => ex
        respond_to_duplicate_record_error(ex)
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def destroy
        link = Link.find(params[:id])
        link.destroy
        render json: {}, status: :ok
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      private

      def link_params
        params.require(:link).permit(:category_id, :tech_id)
      end

      def serialize(links)
        LinkSerializer.new(links, include: [:category, :tech])
      end
    end
  end
end
