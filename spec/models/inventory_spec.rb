require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with a valid item_type and quantity' do
      inventory = Inventory.new(item_type: :pizza, quantity: 10, user: user)
      expect(inventory).to be_valid
    end

    it 'is not valid without an item_type' do
      inventory = Inventory.new(item_type: nil, quantity: 10, user: user)
      expect(inventory).not_to be_valid
    end

    it 'is not valid with a negative quantity' do
      inventory = Inventory.new(item_type: :pizza, quantity: -1, user: user)
      expect(inventory).not_to be_valid
    end

    it 'is valid with a quantity of 0' do
      inventory = Inventory.new(item_type: :pizza, quantity: 0, user: user)
      expect(inventory).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      inventory = Inventory.new(item_type: :pizza, quantity: 10, user: user)
      expect(inventory.user).to eq(user)
    end
  end

  describe 'enum item_type' do
    it 'has the correct item types' do
      inventory = Inventory.new(item_type: :pizza, quantity: 10, user: user)
      expect(inventory.item_type).to eq('pizza')
    end

    it 'allows the correct item types to be assigned' do
      inventory = Inventory.new(item_type: :topping, quantity: 10, user: user)
      expect(inventory).to be_valid
    end

    it 'does not allow invalid item types' do
      expect { Inventory.new(item_type: :invalid_item, quantity: 10, user: user) }.to raise_error(ArgumentError)
    end
  end
end
