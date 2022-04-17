class CardExpensesController < ApplicationController
  before_action :set_card_expense, only: %i[ show edit update destroy ]
  before_action :set_card, only: :index
  # GET /card_expenses or /card_expenses.json
  def index
    @card_expenses = @card.card_expenses
  end

  # GET /card_expenses/1 or /card_expenses/1.json
  def show
  end

  # GET /card_expenses/new
  def new
    @card_expense = CardExpense.new
  end

  # GET /card_expenses/1/edit
  def edit
  end

  # POST /card_expenses or /card_expenses.json
  def create
    @card_expense = CardExpense.new(card_expense_params)

    respond_to do |format|
      if @card_expense.save
        format.html { redirect_to card_expense_url(@card_expense), notice: "Card expense was successfully created." }
        format.json { render :show, status: :created, location: @card_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_expenses/1 or /card_expenses/1.json
  def update
    respond_to do |format|
      if @card_expense.update(card_expense_params)
        format.html { redirect_to card_expense_url(@card_expense), notice: "Card expense was successfully updated." }
        format.json { render :show, status: :ok, location: @card_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_expenses/1 or /card_expenses/1.json
  def destroy
    @card_expense.destroy

    respond_to do |format|
      format.html { redirect_to card_expenses_url, notice: "Card expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:card_id])
    end

    def set_card_expense
      @card_expense = CardExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_expense_params
      params.require(:card_expense).permit(:card_id, :payable_id, :payable_type, :installments, :value, :due_date, :last_date, :status, :total)
    end
end
