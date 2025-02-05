require 'rails_helper'
RSpec.describe InventoryService, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:pizza) { FactoryBot.create(:pizza) }
  let(:crust) { FactoryBot.create(:crust) }
  let(:side) { FactoryBot.create(:side) }
  let(:topping) { FactoryBot.create(:topping) }

  let(:order_params) do
    {
      user_id: user.id,
      pizzas: [{ pizza_id: pizza.id, crust_id: crust.id, size: 'medium', topping_ids: [topping.id] }],
      side_ids: [side.id]
    }
  end

  # Mocking the order object
  let(:order) do
    instance_double('Order', order_pizzas: [double('OrderPizza', pizza: pizza, crust: crust)], 
                            order_toppings: [double('OrderTopping', topping: topping)], 
                            order_sides: [double('OrderSide', side: side)])
  end

  let(:inventory_service) { InventoryService.new }

  describe '#check_and_reserve_stock' do
    context 'when inventory is sufficient' do
      it 'decreases inventory for pizza, crust, topping, and side' do
        # Setup inventory with sufficient stock
        FactoryBot.create(:inventory, item_type: 'pizza', item_id: pizza.id, quantity: 5, user: user)
        FactoryBot.create(:inventory, item_type: 'crust', item_id: crust.id, quantity: 5, user: user)
        FactoryBot.create(:inventory, item_type: 'topping', item_id: topping.id, quantity: 5, user: user)
        FactoryBot.create(:inventory, item_type: 'side', item_id: side.id, quantity: 5, user: user)

        expect(inventory_service.check_and_reserve_stock(order)).to eq(true)

        # Verify inventory quantities are decreased
        expect(Inventory.find_by(item_type: 'pizza', item_id: pizza.id).quantity).to eq(4)
        expect(Inventory.find_by(item_type: 'crust', item_id: crust.id).quantity).to eq(4)
        expect(Inventory.find_by(item_type: 'topping', item_id: topping.id).quantity).to eq(4)
        expect(Inventory.find_by(item_type: 'side', item_id: side.id).quantity).to eq(4)
      end
    end

    context 'when inventory is insufficient' do
      it 'raises an error and does not decrease inventory' do
        # Setup inventory with insufficient stock
        FactoryBot.create(:inventory, item_type: 'pizza', item_id: pizza.id, quantity: 0, user: user)
        FactoryBot.create(:inventory, item_type: 'crust', item_id: crust.id, quantity: 5, user: user)
        FactoryBot.create(:inventory, item_type: 'topping', item_id: topping.id, quantity: 5, user: user)
        FactoryBot.create(:inventory, item_type: 'side', item_id: side.id, quantity: 5, user: user)

        expect(inventory_service.check_and_reserve_stock(order)).to eq(false)

        # Verify inventory quantity is not decreased
        expect(Inventory.find_by(item_type: 'pizza', item_id: pizza.id).quantity).to eq(0)
        expect(Inventory.find_by(item_type: 'crust', item_id: crust.id).quantity).to eq(5)
        expect(Inventory.find_by(item_type: 'topping', item_id: topping.id).quantity).to eq(5)
        expect(Inventory.find_by(item_type: 'side', item_id: side.id).quantity).to eq(5)
      end
    end
  end
end
