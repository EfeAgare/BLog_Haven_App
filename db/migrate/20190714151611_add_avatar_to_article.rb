# frozen_string_literal: true

class AddAvatarToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :avatar, :string
  end
end
