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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110310144836) do

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["site_id"], :name => "index_domains_on_site_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.text     "tags"
    t.string   "title"
    t.text     "data"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["site_id", "name"], :name => "index_pages_on_site_id_and_name", :unique => true

  create_table "site_users", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_users", ["site_id"], :name => "index_site_users_on_site_id"
  add_index "site_users", ["user_id"], :name => "index_site_users_on_user_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.boolean  "active",     :default => true
    t.string   "layout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "favicon",    :default => "/images/fav-hydra.png"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "password_salt",                       :default => "",   :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "permission_mask",                     :default => 1
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                              :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
