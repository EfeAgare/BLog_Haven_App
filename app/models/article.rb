# frozen_string_literal: true

require 'elasticsearch/model'
class Article < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

 
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :like_and_dislikes, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 20 }

  def like(user_id)
    dislike = like_relationships.find(disliked_id: user_id)
    if dislike
      dislike.destroy!
    else
      like = like_relationships.find(liked_id: user_id)
      if like
        like.destroy!
      else
        like_relationships.create!(liked_id: user_id)
      end
    end
  end

  def dislike(user_id)
    like = dislike_relationships.find(liked_id: user_id)
    if like
      like.destroy!
    else
      dislike = dislike_relationships.find(disliked_id: user_id)
      if dislike
        dislike.destroy!
      else
        dislike_relationships.create!(disliked_id: user_id)
      end
    end
  end

  # def like?(article)
  #   self.like_relationships.find(article.id)
  # end

  # def dislike?(article)
  #   self.dislike_relationships.find(article.id)
  # end

  def as_indexed_json(_options = {})
    as_json(
      only: %i[title content avatar created_at],
      include: {
        user: {
          only: %i[name avatar]
        }
      }
    )
  end
end

