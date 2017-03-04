require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'DeleteAllTodosEndpoint' do
  include Rack::Test::Methods
  let(:app) { DeleteAllTodosEndpoint.new repo: repo }

  let(:response) { delete '/todos' }
  let(:repo) { double(:repo, delete_all: true ) }

  describe 'on success' do
    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'deletes all the todos from the repo' do
      expect(repo).to receive(:delete_all)
      response
    end
  end
end
