require 'swagger_helper'

RSpec.describe 'api/v1/links', type: :request do

  path '/api/v1/links' do

    get('List links') do
      tags "Links"
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

    post('Create link') do
      tags "Links"
      security [ { bearer: [] } ]
      description "Creates a new link between a tech and a category"
      consumes "application/json"
      parameter name: :link,
        in: :body,
        required: true,
        schema: {
          type: "object",
          properties: {
            link: {
              type: :object,
              properties:  {
                category_id: { type: :integer },
                tech_id: { type: :integer }
              }
            },
          }
        }
      response(200, 'Successful') do
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
      response '401', 'Unauthorized' do
        run_test!
      end
      response '409', 'Link already exists' do
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

  path '/api/v1/links/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    get('Show link') do
      tags "Links"
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
      response '404', 'Link Not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end

    delete('Delete link') do
      tags "Links"
      security [ { bearer: [] } ]
      description "Deletes the link between a tech and a category"
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
      response '404', 'Link Not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end
end
