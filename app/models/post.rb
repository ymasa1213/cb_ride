class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :image, destroy: false

  validates :title, presence: true
  validates :body, presence: true

# 検索
  def self.search(keyword)　
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end

end
