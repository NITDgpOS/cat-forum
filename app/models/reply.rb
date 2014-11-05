class Reply < ActiveRecord::Base
    include PublicActivity::Common
	belongs_to :user
	belongs_to :new_thread
	has_many :like_count_replies, :dependent => :destroy
    has_many :dislike_count_replies, :dependent => :destroy
    has_many :reply_flags, :dependent => :destroy
    validates_presence_of :content
end
