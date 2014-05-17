json.array!(@entretains) do |entretain|
  json.extract! entretain, :id, :user_id, :title, :content, :state
  json.url entretain_url(entretain, format: :json)
end
