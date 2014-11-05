class LikeCountReply < ActiveRecord::Base
	include PublicActivity::Common
	belongs_to :reply
    belongs_to :user
end
