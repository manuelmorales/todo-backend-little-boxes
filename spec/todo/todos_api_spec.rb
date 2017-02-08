require_relative '../helper'
require 'rack/test'
require'json'

require 'json'
require 'little_boxes'

module Todo
  class GetAllTodoApi
    include LittleBoxes::Configurable

    dependency :repo

    def call(env)
      all = repo.all

      [
        200,
        {'Content-Type' => 'application/json'},
        [all.map{ |t| {title: t.title, completed: t.completed} }.to_json]
      ]
    end
  end
end

RSpec.describe 'TodosApi' do
  describe 'POST /todos' do
    include Rack::Test::Methods

    let(:response) { get '/todos' }
    let(:todo) { OpenStruct.new(title: 'laundry', completed: true) }
    let(:repo) { double(:repo) }

    def app
      TodosApi
    end

    describe 'when found' do
      before { allow(repo).to receive(:all).and_return([todo]) }

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns the serialized todo in JSON' do
        expect(response.headers['Content-Type']).to match(/application\/json/)

        body = JSON.parse(response.body)

        expect(body).to eq [{
          "completed" => todo.completed,
          "title" => todo.title,
        }]
      end
    end
  end
end
