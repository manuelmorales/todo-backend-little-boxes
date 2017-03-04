require_relative '../helper'

RSpec.describe 'TodoEntity' do
  it 'has a title' do
    todo = TodoEntity.new title: 'laundry'
    expect(todo.title).to eq 'laundry'

    todo.title = 'laundry again'
    expect(todo.title).to eq 'laundry again'
  end

  it 'has a completed' do
    todo = TodoEntity.new completed: true
    expect(todo.completed).to be true

    todo.completed = false
    expect(todo.completed).to be false
  end

  it 'has an id' do
    todo = TodoEntity.new completed: true, id: 2
    expect(todo.id).to be 2

    todo.id = 3
    expect(todo.id).to be 3
  end

  it 'has an order' do
    todo = TodoEntity.new completed: true, id: 2, order: 20
    expect(todo.order).to be 20

    todo.order = 21
    expect(todo.order).to be 21
  end
end
