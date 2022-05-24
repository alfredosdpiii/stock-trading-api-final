class QuotesController < ApplicationController
  def index
    if params[:symbol].present?
      redirect_to quote_path(params[:symbol].upcase)
    else
      redirect_to stocks_path
    end
  end

  def show
    symbol = params[:symbol].upcase
    @quote = Stock.new_lookup symbol
    @stock = current_user.stocks.find_by_symbol symbol

    return if @quote

    flash[:alert] = 'Stock not found.'
    render :new
  end
end

def new
  @quote = Quote.new
end
