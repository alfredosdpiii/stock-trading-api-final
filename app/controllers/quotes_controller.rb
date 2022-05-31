class QuotesController < ApplicationController
  before_action :authenticate_user!
  def index
    symbol = params[:symbol].upcase
    @quote = Stock.new_lookup symbol
    @stock = current_user.stocks.find_by_symbol symbol

    stock = @quote

    render json: stock
    return if @quote

    response = 'Stock not found'
    render json: response
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
