# frozen_string_literal: true

class LikeAndDislikesController < ApplicationController
  before_action :authenticated

  def like
    @article = Article.find_by(id: params[:article_id])
    dislike = LikeAndDislike.where(status: 'dislike', article_id: @article.id, user_id: params[:user_id])

    if dislike.exists?
      dislike.destroy_all
      like_params
    else
      like_params
    end
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def dislike
    @article = Article.find_by(id: params[:article_id])
    like = LikeAndDislike.where(status: 'like', article_id: @article.id, user_id: params[:user_id])
    if like.exists?
      like.destroy_all
      dislike_params
    else
      dislike_params
    end
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  private

  def dislike_params
    dislike = LikeAndDislike.where(status: 'dislike', article_id: @article.id, user_id: params[:user_id])
    if dislike.exists?
      dislike.destroy_all
    else
      @article.like_and_dislikes.create(status: 'dislike', user_id: params[:user_id])
    end
  end

  def like_params
    like = LikeAndDislike.where(status: 'like', article_id: @article.id, user_id: params[:user_id])
    if like.exists?
      like.destroy_all
    else
      @article.like_and_dislikes.create(status: 'like', user_id: params[:user_id])
    end
  end
end
