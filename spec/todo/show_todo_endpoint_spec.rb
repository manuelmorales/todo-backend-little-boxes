require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'ShowTodoEndpoint' do
  include Rack::Test::Methods
  let(:app) { ShowTodoEndpoint.new repo: repo, serialize: serialize }
  let(:todo) { TodoEntity.new id: 'the-uuid', title: 'laundry' }
  let(:serialize) { -> (todo) { { title: todo.title } } }

  let(:response) do
    get(
      '/todos/the-uuid',
      {},
      {"router.params" => { id: "the-uuid"} }
    )
  end

  describe 'on success' do
    let(:repo) do
      double(:repo).tap do |r|
        allow(r).to receive(:find).with('the-uuid').and_return(todo)
      end
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns the todo in the body as JSON' do
      expect(response.headers['Content-Type']).to match('application/json')
      body = JSON.parse(response.body)
      expect(body['title']).to eq 'laundry'
    end
  end

  describe 'when not found' do
    let(:repo) { double(:repo, find: nil) }

    it 'returns 404' do
      expect(response.status).to eq 404
    end
  end
end
