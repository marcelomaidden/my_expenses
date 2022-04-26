class CardCategoriesController < ApplicationController
  before_action :set_card_category, only: %i[show edit update destroy]
  before_action :set_statuses, only: %i[new edit update create]

  # GET /card_categories or /card_categories.json
  def index
    @card_categories = CardCategory.all
  end

  # GET /card_categories/1 or /card_categories/1.json
  def show; end

  # GET /card_categories/new
  def new
    @card_category = CardCategory.new
  end

  # GET /card_categories/1/edit
  def edit; end

  # POST /card_categories or /card_categories.json
  def create
    @card_category = CardCategory.new(card_category_params)

    respond_to do |format|
      if @card_category.save
        format.html { redirect_to card_category_url(@card_category), notice: 'Card category was successfully created.' }
        format.json { render :show, status: :created, location: @card_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_categories/1 or /card_categories/1.json
  def update
    respond_to do |format|
      if @card_category.update(card_category_params)
        format.html { redirect_to card_category_url(@card_category), notice: 'Card category was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_categories/1 or /card_categories/1.json
  def destroy
    @card_category.destroy

    respond_to do |format|
      format.html { redirect_to card_categories_url, notice: 'Card category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card_category
    @card_category = CardCategory.find(params[:id])
  end

  def set_statuses
    @statuses = CardCategory::STATUS.map { |key, _value| key }.sort
  end

  # Only allow a list of trusted parameters through.
  def card_category_params
    params.require(:card_category).permit(:name, :status)
  end
end
