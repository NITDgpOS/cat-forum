class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :omniauthable,
         omniauth_providers: [:facebook]

  has_many :new_threads
  has_many :replies
  has_many :like_counts
  has_many :dislike_counts
  has_many :like_count_replies
  has_many :dislike_count_replies
  has_many :new_thread_flags
  has_many :reply_flags
  

  mount_uploader :image, ImageUploader
  # has_attached_file :image, :styles => { :small => "200x200>" },
  #                   :default_url => "/assets/:style/user.jpg"
  # validates_attachment :image,
  #   :size => { :in => 0..10.megabytes },
  #   :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
  validates_presence_of :username

  def self.look(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name # assuming the user model has a name
      # assuming the user model has an image
      #user.remote_image_url = auth.info.image.gsub('http://', 'https://')
      
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] &&
                session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  # new function to set the password without knowing the current password
  # used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    encrypted_password.blank?
  end

  # new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end

  def add_new_thread(new_thread_id)
    current_item = like_counts.where(new_thread_id: new_thread_id).first
    if current_item
      # current_item.quantity += 1
    else
      current_item = LikeCount.new(new_thread_id: new_thread_id)
      like_counts << current_item
    end
    current_item
  end

  def add_new_thread_dislike(new_thread_id)
    current_item = dislike_counts.where(new_thread_id: new_thread_id).first
    if current_item
      # current_item.quantity += 1
    else
      current_item = DislikeCount.new(new_thread_id: new_thread_id)
      dislike_counts << current_item
    end
    current_item
  end

  def add_new_thread_flag(new_thread_id)
    current_item = new_thread_flags.where(new_thread_id: new_thread_id).first
    if current_item
      # current_item.quantity += 1
    else
      current_item = NewThreadFlag.new(new_thread_id: new_thread_id)
      new_thread_flags << current_item
    end
    current_item
  end

  def add_reply(reply_id)
    current_item = like_count_replies.where(reply_id: reply_id).first
    if current_item
      # current_item.quantity += 1
    else
      current_item = LikeCountReply.new(reply_id: reply_id)
      like_count_replies << current_item
    end
    current_item
  end

  def add_reply_dislike(reply_id)
    current_item = dislike_count_replies.where(reply_id: reply_id).first
    if current_item
      # current_item.quantity += 1
    else
      current_item = DislikeCountReply.new(reply_id: reply_id)
      dislike_count_replies << current_item
    end
    current_item
  end

  def add_reply_flag(reply_id)
    current_item = reply_flags.where(reply_id: reply_id).first
    if current_item
      # current_item.quantity += 1
    else
      current_item = ReplyFlag.new(reply_id: reply_id)
      reply_flags << current_item
    end
    current_item
  end

  def update_badge(user_id)
    user = User.find_by_id(user_id)
    user.badge =
      case user.points
      when -100_000..199
        'Gungan'
      when 200..399
        'EWOK'
      when 400..799
        'Wookiee'
      when 800..1599
        'Stormtrooper'
      when 1600..3199
        'Clone Caption'
      when 3200..4999
        'Clone Commander'
      when 5000..9999
        'Jedi Apprentice'
      when 10_000..14_999
        'Jedi'
      when 15_000..19_999
        'Jedi Knight'
      when 20_000..29_999
        'Jedi Master'
      when 30_000..49_999
        'Yoda'
      else
        'The Chosen One'
      end
  end
end
