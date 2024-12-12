require 'rails_helper'

RSpec.describe HelloWorld, type: :model do
  it 'has a valid factory' do
    expect(build(:hello_world)).to be_valid
  end

  it 'is invalid without a name' do
    hello_world = HelloWorld.new(name: nil)
    expect(hello_world).to be_invalid
  end

  it 'returns a greeting' do
    hello_world = HelloWorld.new(name: 'World')
    expect(hello_world.greet).to eq('Hello, World!')
  end
end