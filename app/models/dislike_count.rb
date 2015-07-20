class DislikeCount < ActiveRecord::Base
  belongs_to :new_thread
  belongs_to :user
end
