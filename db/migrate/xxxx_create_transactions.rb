class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 15, scale: 2
      t.string :transaction_type
      t.references :source_wallet, foreign_key: { to_table: :wallets }
      t.references :target_wallet, foreign_key: { to_table: :wallets }

      t.timestamps
    end
  end
end
