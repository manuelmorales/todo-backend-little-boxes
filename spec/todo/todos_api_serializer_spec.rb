require_relative '../helper'

RSpec.describe 'TodosApiSerializer' do
  let(:serializer) { TodosApiSerializer.new }

  it 'returns main attributes' do
    todo = TodoEntity.new(
      title: 'laundry',
      order: 99,
      id: 'an-uuid',
      completed: true,
    )

    expect(serializer.dump(todo)).to include(
      title: 'laundry',
      order: 99,
      id: 'an-uuid',
      completed: true,
    )
  end
end
