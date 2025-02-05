require 'rails_helper'

RSpec.describe OrderPizza, type: :model do

  describe 'validations' do
    let(:order_pizza) { create(:order_pizza) }

    it 'is valid with valid attributes' do
      expect(order_pizza).to be_valid
    end

    it 'is not valid without a size' do
      order_pizza.size = nil
      expect(order_pizza).to_not be_valid
    end

    it 'is not valid without a price' do
      order_pizza.price = nil
      expect(order_pizza).to_not be_valid
    end

    it 'is not valid with a price less than or equal to zero' do
      order_pizza.price = 0
      expect(order_pizza).to_not be_valid
    end
  end
end
