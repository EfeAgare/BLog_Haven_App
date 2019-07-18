# frozen_string_literal: true

require 'elasticsearch/model'

class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_save :index_articles_in_elasticsearch

  has_many :articles, dependent: :destroy
  has_many :like_and_dislikes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token, :activation_token, :reset_token
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new
  mount_uploader :avatar, AvatarUploader
  before_save   :downcase_email
  before_create :create_activation_digest
  VALID_EMAIL =
    /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # def as_indexed_json(options={})
  #   as_json(
  #     only: [:name, :avatar],
  #     include: [:articles]
  #   )
  # end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Activates an account.
  def activate
    update(activated: true, activated_at: Time.now.in_time_zone)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.activation_account(self).deliver_now
  end

  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update(reset_digest: User.digest(reset_token),
           reset_sent_at: Time.now.in_time_zone)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    # Micropost.where("user_id IN (#{following_ids})
    #                  OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def index_articles_in_elasticsearch
    articles.find_each { |article| article.__elasticsearch__.index_document }
  end
end

# Delete the previous articles index in Elasticsearch
# User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil

# # Create the new index with the new mapping
# User.__elasticsearch__.client.indices.create \
#   index: User.index_name,
#   body: { settings: User.includes(:user).settings.to_hash, mappings: User.includes(:user).mappings.to_hash }

# #Index all article records from the DB to Elasticsearch

# User.import
