require_relative '../helper'

RSpec.describe 'TodosApiSerializer' do
  let(:serializer) { TodosApiSerializer.new todo_path: todo_path }
  let(:todo_path) { -> (todo) { '/the.url' } }

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
    expect(serializer.(todo)).to include(url: '/the.url')
  end
end
