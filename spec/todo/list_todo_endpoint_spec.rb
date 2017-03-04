require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods
  let(:app) { ListTodosEndpoint.new repo: repo, serialize: serialize }
  let(:todo) { TodoEntity.new title: 'laundry' }
  let(:serialize) { -> (todo) { { title: todo.title } } }

  let(:repo) do
    double(:repo).tap do |r|
      allow(r).to receive(:find_all).and_return([todo])
    end
  end

  describe 'GET /todos' do
    let(:response) { get '/todos' }

    describe 'on success' do
      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns the todos in the body as JSON' do
        expect(response.headers['Content-Type']).to match('application/json')
        body = JSON.parse(response.body)
        expect(body.first['title']).to eq 'laundry'
      end
    end
  end
end
