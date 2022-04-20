class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_card
  before_action :set_payables, only: %i[new create edit]
  before_action :set_cards, only: %i[new create edit]
  before_action :set_payable, only: %i[create update]
  # GET /expenses or /expenses.json
  def index
    @expenses = @card.expenses
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = @card.expenses.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = @card.expenses.new(expense_params.except(:payable))
    @expense.payable = @payable

    respond_to do |format|
      if @expense.save
        format.html { redirect_to card_expenses_url(@card), notice: "Card expense was successfully created." }
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
        format.html { redirect_to card_expenses_url(@card), notice: "Card expense was successfully updated." }
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
      format.html { redirect_to expenses_url(@card), notice: "Card expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:card_id])
    end

    def set_payable
      payable_param = expense_params[:payable].split(":")
      @payable = User.find(payable_param[1].to_i) if payable_param[0] == "User"
      @payable = Card.find(payable_param[1].to_i) if payable_param[0] == "Card"
    end

    def set_payables
      @payables = User.from("(SELECT 'User' as payable_type, users.id as payable_id, users.name FROM users \
                              UNION SELECT 'Card' as payable_type, cards.id, cards.name FROM cards) as payable")
                      .select("payable.*")
    end

    def set_cards
      @cards = Card.all.order(name: :asc)
    end

    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:payable, :installments, :description, :value, :due_date, :last_date, :status, :total)
    end
end