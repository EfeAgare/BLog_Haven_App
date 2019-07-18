# frozen_string_literal: true

class CreateLikeAndDislikes < ActiveRecord::Migration[5.2]
  def change
    create_table :like_and_dislikes do |t|
      t.integer :status
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
    end
  end
end
