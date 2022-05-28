require 'rails_helper'

RSpec.describe 'Quotes', type: :request do
  describe 'validate stock symbol' do
    it 'should get valid stock object' do
      user = User.create!(
        email: 'asdp@test.com',
        password: 'abc123'
      )
      user.confirm
      user.update!(approved: true)
      # debugger
      sign_in user
      stock_params = {}
      stock_params[:symbol] = 'TSLA'
      # stock_params[:company_name] = 'Tesla Inc'
      # stock_params[:shares] = 10
      # expect(json.count).to eq(1)
      # expect(json[0]['symbol']).to eq('TSLA')
      get '/quotes', params: { symbol: 'TSLA' }
      json = JSON.parse(response.body)
      # debugger
      expect(json['symbol']).to eq('TSLA')
    end
  end
end
