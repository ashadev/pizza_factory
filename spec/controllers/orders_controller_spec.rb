require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:order_params) do
    {
      user_id: user.id,
      side_ids: [FactoryBot.create(:side).id],
      pizzas: [
        {
          pizza_id: FactoryBot.create(:pizza).id,
          size: 'medium',
          crust_id: FactoryBot.create(:crust).id,
          topping_ids: [FactoryBot.create(:topping).id]
        }
      ]
    }
  end

  let(:order_service) { double("OrderService") }

  before do
    allow(OrderService).to receive(:new).and_return(order_service)
  end

  describe 'POST #create' do
    context 'when order is placed successfully' do
      let(:order) { double("Order", id: 1) }

      before do
        allow(order_service).to receive(:place_order).and_return(order)
      end

      it 'returns success message with order id' do
        post :create, params: { order: order_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Order placed successfully')
        expect(JSON.parse(response.body)['order_id']).to eq(order.id)
      end
    end

    context 'when there is an error placing the order' do
      before do
        allow(order_service).to receive(:place_order).and_raise(StandardError, 'Insufficient inventory')
      end

      it 'returns an error message' do
        post :create, params: { order: order_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Insufficient inventory')
      end
    end
  end

  describe 'POST #cancel' do
    context 'when order is pending' do
      let(:order) { FactoryBot.create(:order, user: user, status: :pending) }

      it 'marks the order as canceled' do
        post :cancel, params: { user_id: user.id, id: order.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Order has been canceled successfully.')
        expect(order.reload.status).to eq('canceled')
      end
    end

    context 'when order is already confirmed or delivered' do
      let(:order) { FactoryBot.create(:order, user: user, status: :confirmed) }

      it 'returns an error message' do
        post :cancel, params: { user_id: user.id, id: order.id }

        expect(JSON.parse(response.body)['error']).to eq('Cannot cancel a confirmed or delivered order.')
      end
    end

    context 'when order is not found' do
      it 'returns an error message' do
        post :cancel, params: { user_id: user.id, id: 999999 }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Order not found')
      end
    end
  end
end
