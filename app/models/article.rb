# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  validates :title, presence: true, length: { minimum: 5}
  validates :content, presence: true, length: { minimum: 20 }

end
