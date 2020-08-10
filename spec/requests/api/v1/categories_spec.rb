require 'swagger_helper'

RSpec.describe 'api/v1/categories', type: :request do

  path '/api/v1/categories' do

    get('List categories') do
      tags "Categories"
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

    post('Create category') do
      tags "Categories"
      security [ { bearer: [] } ]
      description "Creates a new category"
      consumes "application/json"
      parameter name: :category,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            category: {
              type: :object,
              properties:  {
                name: { type: :string },
                description: { type: :string }
              }
            },
          }
        }

      response(201, 'Category Created') do
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

  path '/api/v1/categories/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Show category') do
      tags "Categories"
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
      response '404', 'Category Not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    patch('Update category') do
      tags "Categories"
      security [ { bearer: [] } ]
      consumes "application/json"
      parameter name: :category,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            category: {
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
      response '404', 'Category Not Found' do
        run_test!
      end
      response '422', 'Unprocesable Entity' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    put('Update category') do
      tags "Categories"
      security [ { bearer: [] } ]
      consumes "application/json"
      parameter name: :category,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            category: {
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
      response '404', 'Category Not Found' do
        run_test!
      end
      response '422', 'Unprocesable Entity' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    delete('Delete category') do
      tags "Categories"
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
      response '404', 'Category Not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end
end
