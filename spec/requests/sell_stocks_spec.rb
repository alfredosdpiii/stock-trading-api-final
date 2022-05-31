require 'rails_helper'

RSpec.describe 'SellStocks', type: :request do
  it 'should allow user to buy stock and sell stock' do
    user = User.create!(
      email: 'asdp@test.com',
      password: 'abc123'
    )
    user.confirm
    user.update!(approved: true)
    sign_in user
    stock_params = {}
    stock_params[:symbol] = 'TSLA'
    stock_params[:company_name] = 'Tesla Inc'
    stock_params[:shares] = 10
    stock_params[:cost_price] = 628.16
    user.buy_stock(stock_params, 10)
    # debugger
    user.sell_stock('TSLA', 5)
    get '/portfolio'
    json = JSON.parse(response.body)
    expect(json.count).to eq(1)
    expect(json[0]['shares']).to eq(5)
  end

  # it 'User cant sell more stocks than what he currently has' do
  #   user = User.create!(
  #     email: 'asdp@test.com',
  #     password: 'abc123'
  #   )
  #   user.confirm
  #   user.update!(approved: true)
  #   sign_in user
  #   stock_params = {}
  #   stock_params[:symbol] = 'TSLA'
  #   stock_params[:company_name] = 'Tesla Inc'
  #   stock_params[:shares] = 10
  #   stock_params[:cost_price] = 628.16
  #   user.buy_stock(stock_params, 10)
  #   # debugger
  #   # user.sell_stock('TSLA', 11)
  #   # expect { post '/sell_stocks', params: { symbol: 'TSLA', shares: 11 } }
  #   # json = JSON.parse(response.body)
  #   # expect(json[0]['status']).to eq(406)
  #
  #   # debugger
  #   # get '/portfolio'
  #   # json = JSON.parse(response.body)
  #   # expect(json.count).to eq(1)
  #   # expect(json[0]['shares']).to eq(5)
  # end
end
