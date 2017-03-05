require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'UpdateTodoEndpoint' do
  include Rack::Test::Methods

  let(:app) do
    UpdateTodoEndpoint.new({
      repo: repo,
      entity: TodoEntity,
      serialize: -> (todo) { { completed: todo.completed } },
    })
  end

  let(:response) do
    patch(
      '/todos/the-uuid',
      {completed: true}.to_json,
      {
        'Content-Type' => 'application/json',
        "router.params" => { id: "the-uuid"},
      }
    )
  end

  let(:repo) { double(:repo, find: todo, save: true) }
  let(:todo) { TodoEntity.new }

  describe 'on success' do
    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'saves the todo into the repo' do
      expect(repo).to receive :save do |todo|
        expect(todo.completed).to be true
      end

      response
    end

    it 'returns the created todo in the body as JSON' do
      expect(response.headers['Content-Type']).to match('application/json')
      body = JSON.parse(response.body)
      expect(body['completed']).to eq true
    end
  end

  describe 'when not found' do
    let(:repo) { double(:repo, find: nil) }

    it 'returns 404' do
      expect(response.status).to eq 404
    end
  end
end
