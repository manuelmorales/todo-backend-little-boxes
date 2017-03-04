require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods

  let(:app) do
    CreateTodoEndpoint.new({
      repo: repo,
      entity: TodoEntity,
      serializer: TodosApiSerializer.new
    })
  end

  describe 'POST /todos' do
    let(:response) { post '/todos', {title: 'laundry', completed: 'true'}.to_json, { 'Content-Type' => 'application/json' } }

    let(:repo) do
      double(:repo).tap do |r|
        allow(r).to receive(:save) { |todo| todo.id = 2 }
      end
    end

    describe 'on success' do
      it 'returns 201' do
        expect(response.status).to eq 201
      end

      it 'saves the todo into the repo' do
        expect(repo).to receive :save do |todo|
          expect(todo.title).to eq 'laundry'
        end

        response
      end

      it 'returns the location in the headers' do
        location = response.headers['Location']

        expect(location).to eq '/todos/2'
      end

      it 'returns the created todo in the body as JSON' do
        expect(response.headers['Content-Type']).to match('application/json')
        body = JSON.parse(response.body)
        expect(body['title']).to eq 'laundry'
      end
    end
  end
end
