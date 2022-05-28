class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :symbol
      t.string :company_name
      t.float :shares
      t.float :price
      t.float :value
      t.integer :transaction_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
