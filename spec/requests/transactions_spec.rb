require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  # describe 'GET transactions' do
  #   it 'should display all transactions for user' do
  #     user = User.create!(
  #       email: 'asdp@test.com',
  #       password: 'abc123'
  #     )
  #     user.confirm
  #     user.update!(approved: true)
  #     sign_in user
  #     stock_params = {}
  #     stock_params[:symbol] = 'TSLA'
  #     stock_params[:company_name] = 'Tesla Inc'
  #     stock_params[:shares] = 10
  #     stock_params[:cost_price] = 628.16
  #     user.buy_stock(stock_params, 10)
  #     # debugger
  #     user.sell_stock('TSLA', 5)
  #     # sign_in user
  #     user.transactions
  #     get '/transactions'
  #     json = JSON.parse(response.body)
  #     # debugger
  #     expect(json.count).to eq(0)
  #     expect(json[0]['transaction_type_id']).to eq(0)
  #     expect(json[1]['transaction_type_id']).to eq(1)
  #   end
  # end
end
