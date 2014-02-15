# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140204092125) do

  create_table "authors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["name"], name: "index_authors_on_name", unique: true

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "isbn"
    t.integer  "author_id"
    t.integer  "cat_id"
    t.integer  "copies"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", unique: true
  add_index "books", ["title"], name: "index_books_on_title", unique: true

  create_table "borrows", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.date     "date_of_borrow"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "returned",       default: false
    t.date     "date_of_return"
  end

  create_table "cats", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cats", ["description"], name: "index_cats_on_description", unique: true

  create_table "comments", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.date     "date_of_comment"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userbookranks", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
