# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :current_user
  def create
    @article = Article.includes(:comments).order("comments.created_at asc").find(params[:article_id])
    @comment = @article.comments.create(user_id: current_user.id, body: params[:comment][:body])
    respond_to do |format|
      format.html { redirect_to @article } # no js fallback
      format.js # just renders comments/create.js.erb
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end
end
