# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_716_161_657) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.string 'content'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'avatar'
    t.index ['user_id'], name: 'index_articles_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.text 'body'
    t.bigint 'article_id'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['article_id'], name: 'index_comments_on_article_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'like_and_dislikes', force: :cascade do |t|
    t.integer 'status'
    t.bigint 'user_id'
    t.bigint 'article_id'
    t.index ['article_id'], name: 'index_like_and_dislikes_on_article_id'
    t.index ['user_id'], name: 'index_like_and_dislikes_on_user_id'
  end

  create_table 'microposts', force: :cascade do |t|
    t.text 'content'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[user_id created_at], name: 'index_microposts_on_user_id_and_created_at'
    t.index ['user_id'], name: 'index_microposts_on_user_id'
  end

  create_table 'relationships', force: :cascade do |t|
    t.integer 'follower_id'
    t.integer 'followed_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['followed_id'], name: 'index_relationships_on_followed_id'
    t.index %w[follower_id followed_id], name: 'index_relationships_on_follower_id_and_followed_id', unique: true
    t.index ['follower_id'], name: 'index_relationships_on_follower_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'public_uid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest'
    t.string 'remember_digest'
    t.string 'profession'
    t.text 'bio'
    t.boolean 'admin', default: false
    t.string 'activation_digest'
    t.boolean 'activated', default: false
    t.datetime 'activated_at'
    t.string 'reset_digest'
    t.datetime 'reset_sent_at'
    t.string 'avatar'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'articles', 'users'
  add_foreign_key 'comments', 'articles'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'like_and_dislikes', 'articles'
  add_foreign_key 'like_and_dislikes', 'users'
  add_foreign_key 'microposts', 'users'
end
