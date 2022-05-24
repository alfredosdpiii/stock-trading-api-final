require 'rails_helper'

RSpec.describe Stock, type: :model do
  context 'validating stock parameters' do
    it 'is not valid without symbol' do
      stock = described_class.new
      stock.symbol = nil
      expect(stock).not_to be_valid
    end

    it 'is not valid without company_name' do
      stock = described_class.new
      stock.company_name = nil
      expect(stock).not_to be_valid
    end
  end

  context 'validating stock associations' do
    it 'belongs to a user' do
      stock = Stock.new
      user = User.new
      user.stocks << stock
      expect(stock.user).to be user
    end
  end

  context 'Stock quotes' do
    it 'gets quotes from iex' do
      quote = Stock.new_lookup('AAPL')
      expect(quote.symbol).to eq('AAPL')
    end
  end
end

