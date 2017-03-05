require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'ListTodosEndpoint' do
  include Rack::Test::Methods
  let(:app) { ListTodosEndpoint.new repo: repo, serialize: serialize }
  let(:todo) { TodoEntity.new title: 'laundry' }
  let(:serialize) { -> (todo) { { title: todo.title } } }

  let(:repo) do
    double(:repo).tap do |r|
      allow(r).to receive(:find_all).and_return([todo])
    end
  end

  let(:response) { get '/todos' }

  describe 'on success' do
    it 'returns 200' do
      get '/todos'
      expect(last_response.status).to eq 200
    end

    it 'returns the todos in the body as JSON' do
      get '/todos'
      expect(last_response.headers['Content-Type']).to match('application/json')
      body = JSON.parse(last_response.body)
      expect(body.first['title']).to eq 'laundry'
    end
  end
end
