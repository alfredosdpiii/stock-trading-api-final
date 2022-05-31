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
      sign_in user
      stock_params = {}
      stock_params[:symbol] = 'TSLA'
      get '/quotes', params: { symbol: 'TSLA' }
      json = JSON.parse(response.body)
      expect(json['symbol']).to eq('TSLA')
    end
  end
end
