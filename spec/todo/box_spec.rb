require_relative '../helper'

RSpec.describe Todo::Box do
  subject{ described_class.new }

  it 'has a todos section' do
    expect{ subject.todos }.not_to raise_error
  end

  it 'provides todos.store as a Hash' do
    expect(subject.todos.store).to be_a Hash
  end

  describe 'todos.entity' do
    let(:entity) { subject.todos.entity }

    it 'can be done' do
      todo = entity.new

      todo.done = true
      expect(todo.done).to eq true
    end

    it 'has a description' do
      todo = entity.new

      todo.description = 'Do the laundry'
      expect(todo.description).to eq 'Do the laundry'
    end
  end
end
