class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :target_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  # Method untuk menghitung total balance
  def update_balance
    credit_transactions = self.target_transactions.sum(:amount)
    debit_transactions = self.source_transactions.sum(:amount)
    self.update(balance: credit_transactions - debit_transactions)
  end
end
