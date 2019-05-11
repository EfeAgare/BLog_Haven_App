# frozen_string_literal: true

class User < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new
  before_save { email.downcase! }
  VALID_EMAIL =
    /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
