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

ActiveRecord::Schema.define(version: 20180226201711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "requests", force: :cascade do |t|
    t.string "uuid"
    t.text "full_body"
    t.hstore "parameters", default: {}
    t.integer "response"
    t.boolean "successful"
    t.float "view_time"
    t.float "ar_time"
    t.float "total_time"
    t.string "controller"
    t.string "action"
    t.string "uri"
    t.boolean "has_warning"
    t.text "message"
    t.datetime "timestamp"
    t.string "request_type"
    t.string "render"
    t.float "render_time"
    t.index ["controller"], name: "index_requests_on_controller"
    t.index ["has_warning"], name: "index_requests_on_has_warning"
    t.index ["request_type"], name: "index_requests_on_request_type"
    t.index ["response"], name: "index_requests_on_response"
    t.index ["successful"], name: "index_requests_on_successful"
    t.index ["total_time"], name: "index_requests_on_total_time"
  end

end
