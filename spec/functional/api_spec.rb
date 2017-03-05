require_relative '../helper'
require 'rack/test'
require'json'

RSpec.describe 'API' do
  include Rack::Test::Methods

  let(:box) do
    Box.new.tap do |box|
      box.cfg.merge!({ port: 9292, url: 'http://example.com' })
    end
  end

  let(:app) { box.rack.main }

  def response_body
    JSON.parse(last_response.body)
  end

  def create_todo
    post(
      '/todos',
      { title: 'laundry', completed: true, order: 9 }.to_json,
      { 'Content-Type' => 'application/json' },
    )

    expect(last_response.status).to be 201
    last_response.headers['Location'].split('/').last
  end

  def get_todo(id)
    get "/todos/#{id}"
    expect(last_response.status).to be 200
    response_body
  end

  describe 'GET /todos' do
    it 'returns the list of todos' do
      id = create_todo

      get '/todos'
      expect(response_body.first['id']).to eq id
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'
    end
  end

  describe 'POST /todos' do
    it 'creates a todo' do
      post(
        '/todos',
        { title: 'laundry', completed: true, order: 9 }.to_json,
        { 'Content-Type' => 'application/json' },
      )

      expect(last_response.status).to be 201
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'
      expect(response_body).to include('title' => 'laundry')

      id = last_response.headers['Location'].split('/').last

      todo = get_todo(id)
      expect(todo).to include('title' => 'laundry')
      expect(todo['url']).to start_with('http://example.com/todos')
    end
  end

  describe 'DELETE /todos/:id' do
    it 'deletes a todo' do
      id = create_todo

      expect(last_response.status).to be 201
      id = last_response.headers['Location'].split('/').last

      delete "/todos/#{id}"
      expect(last_response.status).to be 200
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'

      get "/todos"
      expect(last_response.status).to be 200
      expect(response_body).to be_empty
    end
  end

  describe 'DELETE /todos' do
    it 'deletes all todos' do
      create_todo

      delete "/todos"
      expect(last_response.status).to be 200
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'

      get "/todos"
      expect(last_response.status).to be 200
      expect(response_body).to be_empty
    end
  end

  describe 'PATCH /todos/:id' do
    it 'updates all todos' do
      id = create_todo

      patch(
        "/todos/#{id}",
        { title: 'new title' }.to_json,
        { 'Content-Type' => 'application/json' },
      )

      expect(last_response.status).to be 200
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'

      todo = get_todo(id)
      expect(todo['title']).to eq 'new title'
    end
  end

  describe 'GET /todo/:id' do
    it 'returns the todo' do
      id = create_todo
      get "/todos/#{id}"
      expect(last_response.status).to be 200
      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'
    end
  end

  describe 'CORS' do
    it 'respondes the right headers to the OPTIONS method' do
      response = options '/whatever'
      expect(response.status).to be 200
      expect(response.headers['Access-Control-Allow-Origin']).to eq '*'
    end
  end
end
