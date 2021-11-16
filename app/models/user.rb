class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following
  attachment :profile_image, destroy: false

  def already_likes?(post)
    self.likes.exists?(post_id: post.id)
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
