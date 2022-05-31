class User < ApplicationRecord
  has_many :stocks
  has_many :transactions

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :trader
  end

  def admin?
    self.role == 'admin'
  end

  def trader?
    self.role == 'trader'
  end

  def buy_stock(stock_params, shares)
    # render(json: { error: shares.value, class: shares.class })
    price = stock_params[:cost_price].to_f
    # shares = shares[:shares].to_i
    # debugger
    if check_balance(price, shares)
      symbol = stock_params[:symbol].to_s
      stock = stocks.build(stock_params)
      stock.transact_shares = shares
      stock_portfolio = stocks.find_by_symbol symbol.upcase

      if stock_portfolio
        stock_portfolio.update(
          shares: stock_portfolio.shares + shares
        )

        stock_portfolio.transact_shares = shares
        Transaction.record(stock, 'buy')
        stock_portfolio
      else
        stock.save
        stock.transact_shares = shares
        stock
      end
    end
  end

  def sell_stock(symbol, shares)
    stock = stocks.find_by_symbol symbol
    sold_shares = shares.to_i

    # debugger
    if sold_shares > stock.shares
      nil
      # message = 'you cannot sell more than what you have'
      # return message
      # render(json: { 'message': 'you cannot sell more than what you have' }, status: 403)
    else
      stock.update shares: (stock.shares - sold_shares)
      stock.transact_shares = sold_shares
      stock
    end
  end

  def update_balance(shares, price, type)
    # shares = shares[:shares].to_i
    total = shares * price
    new_balance = if type == 'buy'
                    cash - total
                  else
                    cash + total
                  end
    update!(cash: new_balance)
  end

  def check_balance(price, shares)
    # shares = :shares
    shares.to_i
    total = price * shares
    return true if cash > total
  end
end
