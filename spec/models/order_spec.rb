require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:pizza) { create(:pizza) }
  let(:vegetarian_pizza) { create(:pizza, category: 'vegetarian') }
  let(:non_vegetarian_pizza) { create(:pizza, category: 'non_vegetarian') }
  let(:topping_non_veg) { create(:topping, category: 'non_veg') }
  let(:topping_paneer) { create(:topping, name: 'Paneer') }
  let(:order) { create(:order) }

  describe 'associations' do
    it 'belongs to a user' do
      order = Order.new(user: user, status: :pending)
      expect(order.user).to eq(user)
    end

    it 'has many order_pizzas' do
      FactoryBot.create(:order_pizza, order_id: order.id)
      
      expect(order.order_pizzas.count).to eq(1)
    end

    it 'has many order_sides' do
      FactoryBot.create(:order_side, order_id: order.id)
      expect(order.order_sides.count).to eq(1)
    end
  end
end
