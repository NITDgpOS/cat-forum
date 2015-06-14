class NewThread < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: [:slugged, :history]
	
	has_many :replies, :dependent => :destroy
	belongs_to :user
    has_many :like_counts, :dependent => :destroy
    has_many :dislike_counts, :dependent => :destroy
    has_many :new_thread_flags, :dependent => :destroy
  
    validates_presence_of :title
    validates_presence_of :description

    include PgSearch

    pg_search_scope :search, against: [:title, :description],
       using: {tsearch: {dictionary: "english"}},
       associated_against: {user: :username, replies: :content }

    def self.text_search(query)
    	if query.present?
    		search(query)
    	else
    		scoped
    	end
    end


end 
