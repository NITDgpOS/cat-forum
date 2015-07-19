class LikeCount < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :new_thread
  belongs_to :user
end
