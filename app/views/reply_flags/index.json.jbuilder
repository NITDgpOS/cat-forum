json.array!(@reply_flags) do |reply_flag|
  json.extract! reply_flag, :id, :reply_id, user_id
  json.url reply_flag_url(reply_flag, format: :json)
end