require 'rails_helper'
RSpec.describe OrderService, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:pizza) { FactoryBot.create(:pizza) }
  let(:crust) { FactoryBot.create(:crust) }
  let(:side) { FactoryBot.create(:side) }

  let(:order_params) do
    {
      user_id: user.id,
      pizzas: [{ pizza_id: pizza.id, crust_id: crust.id, size: 'medium', topping_ids: [] }],
      side_ids: [side.id]
    }
  end

  describe '#place_order' do
    context 'when inventory is insufficient' do
      it 'will raise error' do
        order_service = OrderService.new(order_params)

        expect { order_service.place_order }.to raise_error(RuntimeError, "Insufficient inventory to place the order")
      end
    end 

    describe 'when inventory is sufficent' do
      before do
          allow_any_instance_of(InventoryService).to receive(:check_and_reserve_stock).and_return(true)
      end

      context 'when order parameters are valid' do
        it 'creates and returns a new order with status "confirmed"' do
          order_service = OrderService.new(order_params)

          order = order_service.place_order

          expect(order).to be_persisted
          expect(order.status).to eq('confirmed')
          expect(order.user).to eq(user)
          expect(order.order_pizzas.count).to eq(1)
          expect(order.order_sides.count).to eq(1)
          expect(order.total_price).to be > 0
        end
      end

      context 'when pizza size is invalid' do
        it 'raises an error' do
          order_params = {
            user_id: user.id,
            pizzas: [{ pizza_id: pizza.id, crust_id: crust.id, size: 'extra_large', topping_ids: [] }],
            side_ids: []
          }
          order_service = OrderService.new(order_params)

          expect { order_service.place_order }.to raise_error("Invalid pizza size")
        end
      end
    end

    context 'when adding a non-veg topping to a vegetarian pizza' do
      it 'raises an error' do
        pizza = FactoryBot.create(:pizza, category: 'vegetarian')
        topping = FactoryBot.create(:topping, category: 'non_veg')
        order_params = {
          user_id: user.id,
          pizzas: [{ pizza_id: pizza.id, crust_id: crust.id, size: 'medium', topping_ids: [topping.id] }],
          side_ids: [side.id]
        }
        order_service = OrderService.new(order_params)

        expect { order_service.place_order }.to raise_error("Vegetarian pizzas cannot have non-vegetarian toppings")
      end
    end

    context 'when adding more than one non-veg topping to a non-veg pizza' do
      it 'raises an error' do
        pizza = FactoryBot.create(:pizza, category: 'non_vegetarian')
        topping1 = FactoryBot.create(:topping, category: 'non_veg')
        topping2 = FactoryBot.create(:topping, category: 'non_veg')
        order_params = {
          user_id: user.id,
          pizzas: [
            { pizza_id: pizza.id, crust_id: crust.id, size: 'medium', topping_ids: [topping1.id, topping2.id] }
          ],
          side_ids: [side.id]
        }
        order_service = OrderService.new(order_params)

        expect { order_service.place_order }.to raise_error("Only one non-veg topping allowed per non-vegetarian pizza")
      end
    end
  end
end
