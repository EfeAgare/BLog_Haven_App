# frozen_string_literal: true

class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :article
  belongs_to :user
end
