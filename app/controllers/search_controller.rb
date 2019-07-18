# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @articles = []
    else
      response = Article.__elasticsearch__.search(query: { multi_match: { query: params[:q],
                                                                          fields: ['title', 'content', 'user.name'] } })

      @articles = response.results
      @count = response.results.count
      @query = params[:q]
    end
  end
end
