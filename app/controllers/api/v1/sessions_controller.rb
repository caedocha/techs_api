module Api
  module V1
    class SessionsController < ApplicationController

      def create
        user = User.find_by(name: session_params[:name])
        if user && user.authenticate(session_params[:password])
          render json: user_token(user), status: 201
        else
          null_message = OpenStruct.new(message: '', backtrace: [])
          respond_to_unauthorized_error(null_message)
        end
      rescue StandardError => ex
        respond_to_500_error(ex)
      end

      private

      def session_params
        params.require(:session).permit(:name, :password)
      end

      def user_token(user)
        {
          auth_token: Token.encode({ user_id: user.id })
        }
      end

    end
  end
end
