class AddOutstandingBalanceInLoan < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :outstanding_balance, :decimal
  end
end
