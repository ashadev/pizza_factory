require 'rails_helper'

RSpec.describe InventoryRestocksController, type: :controller do
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let(:non_admin_user) { FactoryBot.create(:user, admin: false) }
  let(:item_type) { 'pizza' }
  let(:item_id) { FactoryBot.create(:pizza).id }
  let(:quantity) { 5 }

  describe 'POST #restock' do
    context 'when user is not found' do
      it 'returns a 404 not found error' do
        post :restock, params: { user_id: 999, item_type: item_type, item_id: item_id, quantity: quantity }
        
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User not found.')
      end
    end

    context 'when user is not an admin' do
      it 'returns a 401 unauthorized error' do
        post :restock, params: { user_id: non_admin_user.id, item_type: item_type, item_id: item_id, quantity: quantity }
        
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Only admin can able to add Inventory')
      end
    end

    context 'when quantity is invalid' do
      it 'returns an error for invalid quantity' do
        post :restock, params: { user_id: admin_user.id, item_type: item_type, item_id: item_id, quantity: 0 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid quantity')
      end
    end

    context 'when restock is successful' do
      it 'increases the inventory quantity' do
        # Initial inventory setup
        create(:inventory, item_type: item_type, item_id: item_id, quantity: 10)

        post :restock, params: { user_id: admin_user.id, item_type: item_type, item_id: item_id, quantity: quantity }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Inventory restocked successfully')

        inventory = Inventory.find_by(item_type: item_type, item_id: item_id)
        expect(inventory.quantity).to eq(15)
      end
    end

    context 'when restock fails' do
      it 'returns an error message' do
        # Simulating an error by making the factory fail to save
        allow_any_instance_of(Inventory).to receive(:save).and_return(false)

        post :restock, params: { user_id: admin_user.id, item_type: item_type, item_id: item_id, quantity: quantity }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Failed to restock inventory')
      end
    end
  end
end
