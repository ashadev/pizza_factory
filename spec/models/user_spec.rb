require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'has many orders' do
    FactoryBot.create(:order, user: user)
    
    expect(user.orders.count).to eq(1)
  end

  it 'has many inventories' do
    FactoryBot.create(:inventory, user: user, item_type: 'pizza', item_id: FactoryBot.create(:pizza).id)
    expect(user.inventories.count).to eq(1)
  end
end
