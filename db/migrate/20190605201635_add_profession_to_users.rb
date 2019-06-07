# frozen_string_literal: true

class AddProfessionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profession, :string
    add_column :users, :bio, :text
  end
end
