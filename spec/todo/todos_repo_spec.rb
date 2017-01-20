require_relative '../helper'

require 'ostruct'

RSpec.describe 'TodosRepo' do
  let(:repo) { TodosRepo.new }
  let(:store) { repo.store }

  it 'can store a todo in the store' do
    todo = OpenStruct.new(title: 'desc', completed: true)

    repo.save(todo)

    data = store.values.first

    expect(data[:title]).to eq 'desc'
    expect(data[:completed]).to eq true
  end

  it 'provides an id' do
    todo = OpenStruct.new

    repo.save(todo)

    expect(todo.id).not_to be_nil
  end

  it 'finds the todo' do
    store[37] = {
      id: 37,
      title: 'laundry',
      completed: true,
    }

    todo = repo.find(37)

    expect(todo.id).to eq 37
    expect(todo.title).to eq 'laundry'
    expect(todo.completed).to eq true
  end

  it 'returns nil when not found' do
    expect(repo.find(37)).to be_nil
  end

  it 'uses new_todo() to build the todo' do
    repo.new_todo = lambda { |args| :some_todo }

    store[37] = {
      id: 37,
      title: 'laundry',
      completed: true,
    }

    expect(repo.find 37).to be :some_todo
  end
end
