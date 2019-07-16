class CommentsController < ApplicationController
  before_action :current_user
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(user_id: current_user.id, body: params[:comment][:body])
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
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
