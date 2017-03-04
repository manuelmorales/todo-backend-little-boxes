require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods
  let(:app) { DeleteTodoEndpoint.new repo: repo }

  describe 'DELETE /todos/:id' do
    let(:response) { delete '/todos/37' }
    let(:repo) { double(:repo, delete: true ) }

    describe 'on success' do
      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'deletes the todo from the repo' do
        expect(repo).to receive(:delete).with(37)
        response
      end
    end
  end
end
