class Payment < ActiveRecord::Base
  belongs_to :loan

  validates_numericality_of :amount, presence: true, greater_than: 0

  after_save :update_outstanding_balance, on: :create

  def update_outstanding_balance
    loan.update(outstanding_balance: loan.outstanding_balance - amount)
  end
end
