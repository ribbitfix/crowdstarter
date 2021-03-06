class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username

  has_many :projects

  validates :email, :uniqueness => true
  validates :username, :uniqueness => true
  validates :facebook_uid, :uniqueness => true

  def self.find_or_create_from_auth_hash(hash)
    user = find_by_facebook_uid(hash.uid)
    if user
      return user
    else
      return User.create(:facebook_uid => hash.uid,
                         :email => hash.info.email,
                         :name => hash.info.name,
                         :image_url => hash.info.image,
                         :oauth_token => hash.credentials.token)
    end
  end
end
