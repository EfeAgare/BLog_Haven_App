# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :current_user, only: %i[create edit new user_articles destroy]

  def new
    @article = Article.new
  end

  def create
    @article = if article_params_avatar
                 current_user.articles.new(article_params_avatar)
               else
                 current_user.articles.new(article_params_without_avatar)
               end
    if @article.save
      flash[:success] = 'Article successfully created'
      redirect_to article_url(@article)
    else
      message = ''
      @article.errors.full_messages.map do |msg|
        message += " #{msg}        "
        flash[:error] = message
      end
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if !params[:avatar]
      @article.remove_avatar!
      @article.update(article_params_without_avatar)
      redirect_to @article
    elsif  article_params_avatar
      @article.update(article_params_avatar)
      redirect_to @article
    else
      message = ''
      @article.errors.full_messages.map do |msg|
        message += " #{msg}        "
        flash[:error] = message
      end
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def user_articles
    @articles = Article.where(user_id: params[:user_id])
  end

  def destroy
    @article = Article.find_by(id: params[:id], user_id: current_user.id)
    if @article
      @article.destroy
      flash[:success] = 'Article deleted successfully'
      redirect_to user_articles_path(current_user)
    else
      flash[:error] = 'Article no found'
      redirect_to user_articles_path(current_user)
    end
  end

  private

  def article_params_avatar
    {
      title: params[:title],
      content: params[:content],
      avatar: params[:avatar]
    }
  end

  def article_params_without_avatar
    {
      title: params[:title],
      content: params[:content]
    }
  end
end
