require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    product = FactoryBot.create(:product)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = FactoryBot.build(:product, name: nil)
    expect(product).not_to be_valid
  end
end
