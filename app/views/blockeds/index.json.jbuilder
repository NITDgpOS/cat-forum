json.array!(@blockeds) do |blocked|
  json.extract! blocked, :id, :status
  json.url blocked_url(blocked, format: :json)
end
