require 'swagger_helper'

RSpec.describe 'api/v1/techs', type: :request do

  path '/api/v1/techs' do

    get('List techs') do
      tags "Techs"
      security [ { bearer: [] } ]
      response(200, 'Successful') do

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    post('Create tech') do
      tags "Techs"
      security [ { bearer: [] } ]
      description "Creates a new tech"
      consumes "application/json"
      parameter name: :tech,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            tech: {
              type: :object,
              properties:  {
                name: { type: :string },
                description: { type: :string }
              }
            },
          }
        }
      response(201, 'Tech Created') do
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '422', 'Unprocesable Entity' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end

  path '/api/v1/techs/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Show tech') do
      tags "Techs"
      security [ { bearer: [] } ]
      response(200, 'Successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '404', 'Tech Not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    patch('Update tech') do
      tags "Techs"
      security [ { bearer: [] } ]
      consumes "application/json"
      parameter name: :tech,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            tech: {
              type: :object,
              properties:  {
                name: { type: :string },
                description: { type: :string }
              }
            },
          }
        }
      response(200, 'Successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '404', 'Tech Not Found' do
        run_test!
      end
      response '422', 'Unprocesable Entity' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    put('Update tech') do
      tags "Techs"
      security [ { bearer: [] } ]
      consumes "application/json"
      parameter name: :tech,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            tech: {
              type: :object,
              properties:  {
                name: { type: :string },
                description: { type: :string }
              }
            },
          }
        }
      response(200, 'Successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '404', 'Tech Not Found' do
        run_test!
      end
      response '422', 'Unprocesable Entity' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    delete('Delete tech') do
      tags "Techs"
      security [ { bearer: [] } ]
      response(200, 'Successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '404', 'Tech Not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end
end
