class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[show edit update destroy]
  before_action :require_approved, except: [:index]

  # GET /stocks
  def index
    @stocks = current_user.stocks.where.not(shares: 0).order(symbol: :ASC)
    render json: @stocks
  end

  # GET /stocks/1
  def show; end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit; end

  # POST /stocks
  def create
    @stock = current_user.buy_stock(
      stock_params,
      stock_params[:shares].to_f
    )

    render json: @stock
  end

  # # PATCH/PUT /stocks/1
  # def update
  #   if @stock.update(stock_params)
  #     redirect_to @stock, notice: 'Stock was successfully updated.'
  #     updated = @stock.update(stock_params)
  #     render json: updated
  #   else
  #     render :edit
  #   end
  # end
  #
  # # DELETE /stocks/1
  # def destroy
  #   @stock.destroy
  #   redirect_to stocks_url, notice: 'Stock was successfully destroyed.'
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock
    @stock = Stock.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stock_params
    params.require(:stock).permit :symbol, :company_name,
                                  :shares, :cost_price, :user_id
  end

  def require_approved
    return if current_user.admin?

    render(json: { error: 'not approved', status: 403 }, status: 403) unless current_user.approved?
  end
end
