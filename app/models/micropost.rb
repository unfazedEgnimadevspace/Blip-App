class Micropost < ApplicationRecord
  acts_as_votable
  belongs_to :user
  validates :user_id, presence: true 
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc)}
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                                    size: { less_than: 5.megabytes,
                                    message: "should be less than 5MB" }
    def display_image
      image.variant(resize_to_limit: [250, 300])
    end    

end
