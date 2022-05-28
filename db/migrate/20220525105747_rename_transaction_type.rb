class RenameTransactionType < ActiveRecord::Migration[7.0]
  def change
        rename_column :transactions, :transaction_type, :transaction_type_id
  end
end
