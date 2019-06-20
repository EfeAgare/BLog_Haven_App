# frozen_string_literal: true

class Article < ApplicationRecord
  # has_one_attached :image_url
  mount_uploader :image_url, ImageUrlUploader
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :content, presence: true, length: { minimum: 20 }
  # validates :file_name, image_file_name: { supported_extensions: %w{.jpg .png .jpeg .tif} }
end
