class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :like_and_dislikes, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  validates :title, presence: true, length: { minimum: 5}
  validates :content, presence: true, length: { minimum: 20 }
  

  def like(user_id)
    dislike = self.like_relationships.find(disliked_id: user_id)
    if dislike
      dislike.destroy!
    else
      like = self.like_relationships.find(liked_id: user_id)
      if like
        like.destroy!
      else
        self.like_relationships.create!(liked_id: user_id)
      end
    end
  end

  def dislike(user_id)
    like = self.dislike_relationships.find(liked_id: user_id)
    if like
      like.destroy!
    else
      dislike = self.dislike_relationships.find(disliked_id: user_id)
      if dislike
        dislike.destroy!
      else
        self.dislike_relationships.create!(disliked_id: user_id)
      end
    end
  end

  # def like?(article)
  #   self.like_relationships.find(article.id)
  # end

  # def dislike?(article)
  #   self.dislike_relationships.find(article.id)
  # end
end
