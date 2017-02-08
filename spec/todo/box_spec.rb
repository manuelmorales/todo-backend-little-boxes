require_relative '../helper'

RSpec.describe 'Box' do
  subject{ Todo::Box.new }

  it 'has a todos section' do
    expect{ subject.todos }.not_to raise_error
  end

  it 'has a todos.repo' do
    expect(subject.todos.repo).to be_a TodosRepo
  end

  it 'has an api' do
    pending
    expect(subject.todos.api).not_to be nil
  end

  describe 'todos.entity' do
    let(:entity) { subject.todos.entity }

    it 'can be completed' do
      todo = entity.new

      todo.completed = true
      expect(todo.completed).to eq true
    end

    it 'has a title' do
      todo = entity.new

      todo.title = 'Do the laundry'
      expect(todo.title).to eq 'Do the laundry'
    end
  end
end
