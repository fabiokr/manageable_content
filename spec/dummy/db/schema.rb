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

ActiveRecord::Schema.define(:version => 20110814003912) do

  create_table "manageable_content_page_contents", :force => true do |t|
    t.integer  "page_id"
    t.string   "key"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manageable_content_page_contents", ["page_id", "key"], :name => "index_manageable_content_page_contents_on_page_id_and_key", :unique => true

  create_table "manageable_content_pages", :force => true do |t|
    t.string   "key"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manageable_content_pages", ["key", "locale"], :name => "index_manageable_content_pages_on_key_and_locale", :unique => true

end
