require 'rails_helper'

RSpec.describe 'Stocks', type: :request do
  describe 'GET user stocks' do
    it 'should get user stocks' do
      user = User.create!(
        email: 'asdp@test.com',
        password: 'abc123'
      )
      user.confirm
      user.update!(approved: true)
      # debugger
      sign_in user
      # stock_params = { :symbol => 'TSLA' }
      stock_params = {}
      stock_params[:symbol] = 'TSLA'
      stock_params[:company_name] = 'Tesla Inc'
      stock_params[:shares] = 10
      stock_params[:cost_price] = 628.16
      user.buy_stock(stock_params, shares: 10)
      get '/portfolio'
      json = JSON.parse(response.body)
      # debugger
      expect(json.count).to eq(1)
      expect(json[0]['symbol']).to eq('TSLA')
    end
  end

  describe 'validates stock buy' do
    it 'should allow user to buy stock' do
      user = User.create!(
        email: 'asdp@test.com',
        password: 'abc123'
      )
      user.confirm
      user.update!(approved: true)
      # debugger
      sign_in user
      # stock_params = { :symbol => 'TSLA' }
      stock_params = {}
      stock_params[:symbol] = 'TSLA'
      stock_params[:company_name] = 'Tesla Inc'
      stock_params[:shares] = 10
      stock_params[:cost_price] = 628.16
      user.buy_stock(stock_params, shares: 10)
      get '/portfolio'
      json = JSON.parse(response.body)
      # debugger
      expect(json.count).to eq(1)
      expect(json[0]['user_id']).to eq(user.id)
    end
  end
end
