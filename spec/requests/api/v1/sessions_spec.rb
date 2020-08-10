require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do

  path '/api/v1/login' do

    post('Create session') do
      tags "Sessions"
      consumes "application/json"
      description "Creates a session for the supplied API user and returns a JWT token to be used as a bearer token in the rest of the API"
      parameter name: :session,
        in: :body,
        description: "Session object containing the API user's name and password",
        required: true,
        schema: {
          type: "object",
          properties: {
            session: {
              type: :object,
              properties:  {
                name: { type: :string },
                password: { type: :string }
              }
            },
          }
        }

      response(201, 'Successful') do
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '500', 'Internal server error' do
        run_test!
      end
    end
  end
end
