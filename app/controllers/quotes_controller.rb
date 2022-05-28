class QuotesController < ApplicationController
  before_action :authenticate_user!
  def index
    # if params[:symbol].present?
    #   redirect_to quote_path(params[:symbol].upcase)
    # else
    #   redirect_to stocks_path
    # end
    symbol = params[:symbol].upcase
    @quote = Stock.new_lookup symbol
    @stock = current_user.stocks.find_by_symbol symbol

    stock = @quote

    render json: stock
    return if @quote

    response = 'Stock not found'
    # flash[:alert] = 'Stock not found.'
    render json: response
    # render :new
  end
end

# def show
#   symbol = params[:symbol].upcase
#   @quote = Stock.new_lookup symbol
#   @stock = current_user.stocks.find_by_symbol symbol
#
#   stock = @quote
#
#   render json: stock
#   return if @quote
#
#   response = 'Stock not found'
#   # flash[:alert] = 'Stock not found.'
#   render json: response
#   # render :new
# end

def new
  @quote = Quote.new
end
