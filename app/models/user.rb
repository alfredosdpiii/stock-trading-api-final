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
    symbol = stock_params[:symbol]
    stock = stocks.build(stock_params)
    stock.transact_shares = shares
    stock_portfolio = stocks.find_by_symbol symbol.upcase

    if stock_portfolio
      stock_portfolio.update(
        shares: stock_portfolio.shares + shares
      )

      stock_portfolio.transact_shares = shares
      stock_portfolio
    else
      stock.save
      stock.transact_shares = shares
      stock
    end
  end

  def sell_stock(symbol, shares)
    stock = stocks.find_by_symbol symbol
    sold_shares = shares

    if sold_shares > stock.shares
      flash[:alert] =
        "You only have #{stock.shares} of #{stock.company_name} to sell."
      nil
    else
      stock.update shares: (stock.shares - sold_shares)
      stock.transact_shares = sold_shares
      stock
    end
  end
end
