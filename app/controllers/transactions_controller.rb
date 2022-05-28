class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user
                    .transactions
                    .includes(:transaction_type)
                    .order(created_at: :DESC)
    render json: @transactions
  end
end
