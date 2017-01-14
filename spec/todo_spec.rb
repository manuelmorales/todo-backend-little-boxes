require_relative 'helper'

RSpec.describe 'Todo' do
  it 'is has a version' do
    expect(Todo::VERSION).to eq '0.0.1'
  end
end
