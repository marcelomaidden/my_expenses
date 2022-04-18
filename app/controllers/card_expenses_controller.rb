class CardExpensesController < ApplicationController
  before_action :set_card_expense, only: %i[ show edit update destroy ]
  before_action :set_card, only: :index
  before_action :set_payables, only: %i[new create edit]
  before_action :set_cards, only: %i[new create edit]
  before_action :set_payable, only: %i[create update]
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
    @card_expense = CardExpense.new(card_expense_params.except(:payable))
    @card_expense.payable = @payable

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
      if @card_expense.update(card_expense_params.except(:payable))
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

    def set_payable
      payable_param = card_expense_params[:payable].split(":")
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

    def set_card_expense
      @card_expense = CardExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_expense_params
      params.require(:card_expense).permit(:card_id, :payable, :installments, :description, :value, :due_date, :last_date, :status, :total)
    end
end
