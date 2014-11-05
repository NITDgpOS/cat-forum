json.array!(@new_thread_flags) do |new_thread_flag|
  json.extract! new_thread_flag, :id, :new_thread_id, user_id
  json.url new_thread_flag_url(new_thread_flag, format: :json)
end