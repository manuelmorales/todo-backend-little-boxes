require_relative '../helper'

RSpec.describe 'Router' do
  let(:todo) { TodoEntity.new id: 'the-uuid' }
  let(:router) { Router.new server_url: 'http://example.com' }

  it 'generates todo_url' do
    expect(router.todo_url(todo)).to eq 'http://example.com/todos/the-uuid'
  end
end
