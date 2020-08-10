module Api
  module V1
    class TechsController < ApplicationController

      before_action :authenticate_user!

      def index
        render json: serialize(Tech.all)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def show
        @tech = Tech.find(params[:id])
        render json: serialize(@tech)
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def create
        @tech = Tech.new(tech_params)
        if @tech.save
          render json: serialize(@tech), status: :created
        else
          render json: @tech.errors, status: :unprocessable_entity
        end
      rescue ActionController::ParameterMissing => ex
        respond_to_missing_params_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def update
        @tech = Tech.find(params[:id])
        if @tech.update(tech_params)
          render json: serialize(@tech), status: :ok
        else
          render json: @tech.errors, status: :unprocessable_entity
        end
      rescue ActionController::ParameterMissing => ex
        respond_to_missing_params_error(ex)
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      def destroy
        @tech = Tech.find(params[:id])
        @tech.destroy
        render json: {}, status: :ok
      rescue ActiveRecord::RecordNotFound => ex
        respond_to_not_found_error(ex)
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      private

      def serialize(techs)
        TechSerializer.new(techs, include: [:categories])
      end

      def tech_params
        params.require(:tech).permit(:name, :description)
      end
    end
  end
end
