require_relative '../helper'

RSpec.describe 'TodosApiSerializer' do
  let(:serializer) { TodosApiSerializer.new todo_url: todo_url }
  let(:todo_url) { -> (todo) { 'http://example.com/the.url' } }

  let(:todo) do
    TodoEntity.new(
      title: 'laundry',
      order: 99,
      id: 'an-uuid',
      completed: true,
    )
  end

  it 'returns main attributes' do
    expect(serializer.(todo)).to include(
      title: 'laundry',
      order: 99,
      id: 'an-uuid',
      completed: true,
    )
  end

  it 'has a url' do
    expect(serializer.(todo)).to include(url: 'http://example.com/the.url')
  end
end
