class PaymentsController < ActionController::API
  before_action :check_outstanding_balance, on: :create
  before_action :check_valid_amount, on: :create

  rescue_from ActiveRecord::RecordNotFound do
    render json: 'loan not found', status: :not_found
  end

  def create
    @payment = @loan.payments.new(payment_params)
    @payment.save ? (render json: { message: 'payment successful' }) : (render json: @payment.errors.full_messages)
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end

  def check_outstanding_balance
    @loan = Loan.find(params[:loan_id].to_i)
    render json: { message: 'no loan amount is due' } if @loan.outstanding_balance.zero?
  end

  def check_valid_amount
    render json: { message: 'payment amount is invalid' } if @loan.outstanding_balance < params[:payment][:amount].to_i
  end
end
