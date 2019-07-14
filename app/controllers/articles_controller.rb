# frozen_string_literal: true

class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    if article_params_avatar
      @article = current_user.articles.new(article_params_avatar)
    else
      @article = current_user.articles.new(article_params_without_avatar)
    end
    binding.pry
    if @article.saveq
      flash[:success] = 'Article successfully created'
      redirect_to article_url(@article)
    else
      message = ""
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
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
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
