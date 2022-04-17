json.extract! card_expense, :id, :card_id, :payable_id, :payable_type, :installments, :value, :due_date, :last_date, :status, :total, :created_at, :updated_at
json.url card_expense_url(card_expense, format: :json)
