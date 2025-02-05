require 'rails_helper'

RSpec.describe Crust, type: :model do
  let(:crust) { create(:crust) }

  describe 'validations' do
    it 'is valid with a name' do
      crust = Crust.new(name: 'Thin Crust')
      expect(crust).to be_valid
    end

    it 'is not valid without a name' do
      crust = Crust.new(name: nil)
      expect(crust).not_to be_valid
    end

    it 'is not valid with a non-unique name' do
      create(:crust, name: 'Thin Crust')
      crust = Crust.new(name: 'Thin Crust')
      
      expect(crust).not_to be_valid
    end
  end
end
