ActiveRecord::Schema.define(version: 2020_05_30_160152) do

  enable_extension "plpgsql"

  create_table "requests", force: :cascade do |t|
    t.string "score"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "flat_id"
  end

end
