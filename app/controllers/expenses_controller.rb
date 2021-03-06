class ExpensesController < ApplicationController
  before_action :expenses_billable
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_payables, only: %i[new create edit]
  before_action :set_billables, only: %i[new create edit index]
  before_action :set_payable, only: %i[create update]
  # GET /expenses or /expenses.json
  def index
    @expenses = @billable.expenses
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = @billable.expenses.new
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses or /expenses.json
  def create
    @expense = @billable.expenses.new(expense_params.except(:payable))
    @expense.payable = @payable

    respond_to do |format|
      if @expense.save
        format.html { redirect_to helpers.expenses_path(@billable), notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params.except(:payable))
        @expense.update payable: @payable
        format.html { redirect_to helpers.expenses_path(@billable), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to helpers.expenses_path(@billable), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def expenses_billable
    @billable_type = if params[:card_id]
                       'cards'
                     elsif params[:phone_id]
                       'phones'
                     end

    @billable = if params[:card_id]
                  Card.find(params[:card_id])
                else
                  Phone.find(params[:phone_id])
                end
  end

  def set_payable
    payable_param = expense_params[:payable].split(':')
    @payable = User.find(payable_param[1].to_i) if payable_param[0] == 'User'
    @payable = Card.find(payable_param[1].to_i) if payable_param[0] == 'Card'
    @payable = Phone.find(payable_param[1].to_i) if payable_param[0] == 'Phone'
  end

  def set_payables
    @payables = User.from("(SELECT 'User' as payable_type, users.id as payable_id, users.name FROM users \
                              UNION SELECT 'Card' as payable_type, cards.id, cards.name FROM cards
                              UNION SELECT 'Phone' as payable_type, phones.id, phones.number FROM phones) as payable")
      .select('payable.*')
  end

  def set_billables
    @billables = if params[:card_id]
                   Card.all.order(name: :asc)
                 else
                   Phone.all.order(number: :asc)
                 end
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:payable, :installments, :description, :value, :due_date, :last_date, :status,
                                    :total)
  end
end
