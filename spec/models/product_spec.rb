require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save a valid product' do
      @category = Category.create(name:"Art")
      product = Product.new(
        name: "Mona Lisa",
        price: 0.99,
        quantity: 1,
        category_id: @category.id
        )
      expect(product).to (be_valid)
    end

    it 'should not save without a valid name' do
      @category = Category.create(name:"Art")
      product = Product.new(
        name: nil,
        price: 0.99,
        quantity: 1,
        category_id: @category.id
        )
      expect(product).to_not (be_valid)
    end

    it 'should not save without a valid price' do
      @category = Category.create(name:"Art")
      product = Product.new(
        name: "Mona Lisa",
        price: nil,
        quantity: 1,
        category_id: @category.id
        )
      expect(product).to_not (be_valid)
    end

    it 'should not save without a valid quantity' do
      @category = Category.create(name:"Art")
      product = Product.new(
        name: "Mona Lisa",
        price: 0.99,
        quantity: nil,
        category_id: @category.id
        )
      expect(product).to_not (be_valid)
    end

    it 'should not save without a catagory_id' do
      @category = Category.create(name:"Art")
      product = Product.new(
        name: "Mona Lisa",
        price: 0.99,
        quantity: 1,
        category_id: nil
        )
      expect(product).to_not (be_valid)
    end
  end
end