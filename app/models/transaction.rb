class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_wallets

  after_create :update_wallet_balances

  private

  def validate_wallets
    if transaction_type == 'credit' && source_wallet.present?
      errors.add(:source_wallet, 'Source wallet should be nil for credit transaction')
    elsif transaction_type == 'debit' && target_wallet.present?
      errors.add(:target_wallet, 'Target wallet should be nil for debit transaction')
    end
  end

  def update_wallet_balances
    source_wallet.update_balance if source_wallet
    target_wallet.update_balance if target_wallet
  end
end
