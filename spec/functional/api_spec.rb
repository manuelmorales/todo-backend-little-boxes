require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods
  let(:box) { Box.new }
  let(:app) { box.rack_app }

  def response_body
    JSON.parse(last_response.body)
  end


  describe 'GET /todos' do
    let(:response) { get '/todos' }

    describe 'when empty' do
      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns the list in JSON' do
        expect(response.headers['Content-Type']).to match(/application\/json/)

        body = JSON.parse(response.body)
        expect(body).to eq []
      end
    end

    describe 'with a Todo' do
      let(:todo) { OpenStruct.new(title: 'laundry', completed: true, order: 0) }
      let(:repo) { box.todos.repo }
      before { repo.save todo }

      it 'returns the list in JSON' do
        expect(response.headers['Content-Type']).to match(/application\/json/)

        body = JSON.parse(response.body)
        expect(body).to eq [{
          "title"=>"laundry",
          "completed"=>true,
          "order"=>0,
        }]
      end
    end
  end

  describe 'POST /todos' do
    it 'creates a todo' do
      post(
        '/todos',
        { title: 'laundry', completed: true, order: 9 }.to_json,
        { 'Content-Type' => 'application/json' },
      )

      expect(last_response.status).to be 201
      expect(response_body).to include('title' => 'laundry')

      id = last_response.headers['Location'].split('/').last

      get "/todos"
      expect(last_response.status).to be 200
      expect(response_body.first).to include('title' => 'laundry')
    end
  end

  describe 'DELETE /todos/:id' do
    it 'deletes a todo' do
      post(
        '/todos',
        { title: 'laundry', completed: true, order: 9 }.to_json,
        { 'Content-Type' => 'application/json' },
      )

      expect(last_response.status).to be 201
      id = last_response.headers['Location'].split('/').last

      delete "/todos/#{id}"
      expect(last_response.status).to be 200

      get "/todos"
      expect(last_response.status).to be 200
      expect(response_body).to be_empty
    end
  end

  describe 'DELETE /todos' do
    it 'deletes all todos' do
      post(
        '/todos',
        { title: 'laundry', completed: true, order: 9 }.to_json,
        { 'Content-Type' => 'application/json' },
      )

      expect(last_response.status).to be 201
      id = last_response.headers['Location'].split('/').last

      delete "/todos"
      expect(last_response.status).to be 200

      get "/todos"
      expect(last_response.status).to be 200
      expect(response_body).to be_empty
    end
  end

  describe 'CORS' do
    it 'respondes the right headers to the OPTIONS method' do
      response = options '/whatever'
      expect(response.status).to be 200
      expect(response.headers['Access-Control-Allow-Origin']).to eq '*'
    end
  end
end
