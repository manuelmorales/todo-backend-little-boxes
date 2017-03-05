require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'DELETE /todos/:id' do
  include Rack::Test::Methods
  let(:app) { DeleteTodoEndpoint.new repo: repo }

  let(:response) do
    delete(
      '/todos/an-uuid',
      {},
      {"router.params" => { id: "an-uuid"} }
    )
  end

  describe 'on success' do
    let(:repo) { double(:repo, find: todo, delete: true) }
    let(:todo) { double(:todo) }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'deletes the todo from the repo' do
      expect(repo).to receive(:delete).with(todo)
      response
    end
  end

  describe 'when not found' do
    let(:repo) { double(:repo, find: nil) }

    it 'returns 404' do
      expect(response.status).to eq 404
    end
  end
end
