require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods
  let(:app) { DeleteTodoEndpoint.new repo: repo }

  describe 'DELETE /todos/:id' do
    let(:response) do
      delete(
        '/todos/an-uuid',
        {},
        {"router.params" => { id: "an-uuid"} }
      )
    end

    let(:repo) { double(:repo, delete: true ) }

    describe 'on success' do
      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'deletes the todo from the repo' do
        expect(repo).to receive(:delete).with('an-uuid')
        response
      end
    end

    describe 'on not found' do
      it 'returns 404'
    end
  end
end
