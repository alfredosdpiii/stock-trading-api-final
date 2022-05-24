class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string 'company_name'
      t.float 'price'
      t.float 'shares'
      t.string 'symbol'
      t.float 'value'
      t.timestamps
    end
  end
end
