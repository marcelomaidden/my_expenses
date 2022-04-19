json.extract! card, :id, :user_id, :name, :number, :expiration, :status, :card_category_id, :manager, :cvv, :created_at, :updated_at
json.url card_url(card, format: :json)
