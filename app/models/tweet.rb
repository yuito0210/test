class Tweet < ApplicationRecord

    belongs_to :user 

    mount_uploader :image, ImageUploader

    has_many :tweet_tags, dependent: :destroy
    has_many :tags, through: :tweet_tags

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

end
