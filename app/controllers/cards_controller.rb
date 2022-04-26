class CardsController < ApplicationController
  before_action :billable, only: %i[show]
  before_action :set_card, only: %i[edit update destroy]
  before_action :set_categories, only: %i[new edit create update]
  before_action :set_statuses, only: %i[new edit create update]
  before_action :set_managers, only: %i[new edit create update]

  # GET /cards or /cards.json
  def index
    @cards = [current_user.cards]
    @cards << current_user.managed_cards
  end

  # GET /cards/1 or /cards/1.json
  def show; end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit; end

  # POST /cards or /cards.json
  def create
    @card = current_user.cards.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def billable
    super(model: Card)
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def set_categories
    @categories = CardCategory.active.order(name: :asc).collect { |c| [c.name, c.id] }
  end

  def set_statuses
    @statuses = CardCategory::STATUS.map { |key, _value| key }.sort
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:user_id, :name, :number, :expiration, :status, :card_category_id, :manager_id, :cvv)
  end
end
