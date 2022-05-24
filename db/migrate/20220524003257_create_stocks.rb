class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string 'symbol'
      t.string 'company_name'
      t.float 'shares'
      t.float 'cost_price'
      t.bigint 'user_id', null: false
      t.index ["user_id"], name: "index_stocks_on_user_id"
      t.timestamps
    end
  end
end
