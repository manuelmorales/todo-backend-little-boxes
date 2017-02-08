require_relative '../helper'

RSpec.describe 'TodosRepo' do
  let(:box) { Box.new }
  let(:repo) { box.todos.repo }
  let(:entity) { box.todos.entity }

  it 'builds todos using the entity' do
    todo = OpenStruct.new(title: 'desc', completed: true)
    repo.save(todo)

    expect(repo.find(todo.id)).to be_a entity
  end
end
