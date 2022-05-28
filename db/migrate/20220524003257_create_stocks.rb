class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company_name
      t.float :shares
      t.float :cost_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
