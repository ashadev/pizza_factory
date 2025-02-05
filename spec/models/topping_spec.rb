require 'rails_helper'

RSpec.describe Topping, type: :model do
  describe '#paneer?' do
    it 'returns true if topping name is paneer' do
      topping = build(:topping, name: 'Paneer')
      expect(topping.paneer?).to be true
    end

    it 'returns false if topping name is not paneer' do
      topping = build(:topping, name: 'Mushroom')
      expect(topping.paneer?).to be false
    end
  end
end
