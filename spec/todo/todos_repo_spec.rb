require_relative '../helper'

require 'ostruct'

RSpec.describe 'TodosRepo' do
  let(:repo) { TodosRepo.new(store: store) }
  let(:store) { {} }

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
end
