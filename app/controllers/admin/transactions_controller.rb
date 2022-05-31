class Admin::TransactionsController < ApplicationController
  def index
    @transactions = Transaction
                    .includes(:transaction_type, :user)
                    .all
                    .order(created_at: :DESC)
    render json: @transactions
  end
end
