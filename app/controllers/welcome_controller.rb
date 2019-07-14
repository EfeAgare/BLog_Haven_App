# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @articles = Article.all.limit(9)
  end

  def help; end
end
