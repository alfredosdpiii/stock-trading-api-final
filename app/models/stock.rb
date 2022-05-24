class Stock < ApplicationRecord
  belongs_to :user
  attr_accessor :transact_shares

  validates :symbol, :company_name, presence: true

  def self.new_lookup(symbol)
    client = IEX::Api::Client.new(
      publishable_token: 'pk_da91da07bf424fa58ed0cba5ec0c4f2b',
      secret_token: 'sk_d591fb3d5f274ae6b21e1ce09320ea0b',
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    begin
      new(symbol:,
          company_name: client.company(symbol).company_name,
          cost_price: client.quote(symbol).latest_price)
    rescue StandardError => e
      nil
    end
  end

  def self.check_stocks(symbol)
    where(symbol:).first
  end
end
