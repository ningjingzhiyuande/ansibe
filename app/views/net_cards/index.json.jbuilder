json.array!(@net_cards) do |net_card|
  json.extract! net_card, :id, :applicant_id, :reviewer1_username, :reviewer2_username, :workflow_state, :start_at, :end_at, :quantity
  json.url net_card_url(net_card, format: :json)
end
