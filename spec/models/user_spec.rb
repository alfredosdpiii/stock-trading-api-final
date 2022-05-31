require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validating user email' do
    it 'is not valid without username' do
      user = described_class.new
      user.email = nil
      expect(user).not_to be_valid
    end
  end

  context 'validating user associations' do
    it 'has many stocks' do
      should respond_to(:stocks)
    end

    it 'has many transactions' do
      should respond_to(:transactions)
    end
  end

  context 'User management' do
    it 'can create a user' do
      user = User.new(
        email: 'asdp@test.com',
        password: 'abc123'
      )

      expect(user.valid?).to eq(true)
    end

    it 'can delete a user' do
      initial = User.all.count
      user = User.create!(email: 'asdp@test.com', password: 'abc123')
      user.destroy
      destroyed = User.all.count
      expect(destroyed).to eq(initial)
    end

    it 'user must be unapproved on first create and make trader as default' do
      user = User.create!(email: 'asdp@test.com', password: 'abc123')
      expect(user.approved?).to eq(false)
      expect(user.trader?).to eq(true)
    end
  end

  context 'User trading' do
    it 'can buy stocks' do
      user = User.create!(
        email: 'asdp@test.com',
        password: 'abc123',
        approved: true
      )

      stock_params = {}
      stock_params[:symbol] = 'TSLA'
      stock_params[:company_name] = 'Tesla Inc'
      stock_params[:shares] = 10
      stock = user.buy_stock(stock_params, 10)
      # debugger
      expect(stock.shares).to eq(10)
    end
  end
end
