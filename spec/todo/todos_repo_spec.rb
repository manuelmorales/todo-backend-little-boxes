require_relative '../helper'

require 'ostruct'

RSpec.describe 'TodosRepo' do
  let(:repo) { TodosRepo.new }
  let(:store) { repo.store }

  it 'saves a new todo' do
    todo = OpenStruct.new(title: 'desc', completed: true, order: 0)

    repo.save(todo)

    data = store.values.first

    expect(data[:title]).to eq 'desc'
    expect(data[:completed]).to eq true
    expect(data[:order]).to eq 0
  end

  it 'updates existing todos' do
    todo = OpenStruct.new(title: 'desc', completed: true, order: 0)
    repo.save(todo)
    id = todo.id

    todo.title = 'new title'
    repo.save(todo)

    data = store[id]

    expect(data[:title]).to eq 'new title'
  end

  it 'provides an id' do
    todo = OpenStruct.new

    repo.save(todo)

    data = store.values.first

    expect(todo.id).not_to be_nil
    expect(data[:id]).to eq(todo.id)
  end

  it 'finds the todo' do
    store[37] = {
      id: 37,
      title: 'laundry',
      completed: true,
      order: 0,
    }

    todo = repo.find(37)

    expect(todo.id).to eq 37
    expect(todo.title).to eq 'laundry'
    expect(todo.completed).to eq true
    expect(todo.order).to eq 0
  end

  it 'returns nil when not found' do
    expect(repo.find(37)).to be_nil
  end

  it 'uses new_todo() to build the todo' do
    repo.new_todo = lambda { |args| args }

    store[37] = {
      id: 37,
      title: 'laundry',
      completed: true,
    }

    expect(repo.find 37).to eq({
      id: 37,
      title: 'laundry',
      completed: true,
    })
  end

  it 'returns all of them with #find_all' do
    store[37] = { id: 37, title: 'laundry' }
    store[38] = { id: 38, title: 'homework' }

    todos = repo.find_all

    expect(todos.length).to eq 2
    expect(todos[1].id).to eq 38
    expect(todos[1].title).to eq 'homework'
  end

  it 'deletes todos by id' do
    store[37] = {}
    repo.delete(37)
    expect(store).to be_empty
  end

  it 'deletes all todos with delete_all()' do
    store[37] = {}
    repo.delete_all
    expect(store).to be_empty
  end
end
