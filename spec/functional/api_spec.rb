require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods
  let(:box) { Box.new }
  let(:app) { box.rack_app }

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
      let(:todo) { OpenStruct.new(title: 'laundry', completed: true) }
      let(:repo) { box.todos.repo }
      before { repo.save todo }

      it 'returns the list in JSON' do
        expect(response.headers['Content-Type']).to match(/application\/json/)

        body = JSON.parse(response.body)
        expect(body).to eq [{"title"=>"laundry", "completed"=>true}]
      end
    end
  end

  describe 'POST /todos' do
    let(:response) { post '/todos', {title: 'laundry', completed: 'true'}.to_json, { 'Content-Type' => 'application/json' } }

    describe 'on success' do
      it 'returns 200' do
        pending

        expect(response.status).to eq 200
      end
    end
  end

  describe 'CORS' do
    it 'respondes the right headers to the OPTIONS method' do
      response = options '/whatever'
      expect(response.status).to be 200
    end
  end
end
