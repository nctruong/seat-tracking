# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_17_050748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "advs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "seq"
    t.boolean "playing", default: false
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.boolean "confirmed"
    t.string "passport"
    t.string "phone"
    t.string "boarding_pass"
    t.integer "deck"
    t.string "trip_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "seat"
    t.uuid "trip_id"
    t.boolean "sent_cloud", default: false
    t.string "check_in_time"
    t.string "depart_port_destination_name"
    t.string "depart_port_origin_name"
    t.boolean "active", default: true
    t.index ["active"], name: "index_passengers_on_active"
    t.index ["boarding_pass"], name: "index_passengers_on_boarding_pass"
    t.index ["check_in_time"], name: "index_passengers_on_check_in_time"
    t.index ["passport"], name: "index_passengers_on_passport"
    t.index ["sent_cloud"], name: "index_passengers_on_sent_cloud"
  end

  create_table "trips", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "port_origin_id"
    t.string "port_origin_name"
    t.string "port_destination_id"
    t.string "port_destination_name"
    t.string "depart_date"
    t.string "etd"
    t.string "arrival_date"
    t.string "eta"
    t.string "vessel_name"
    t.integer "available_seats"
    t.integer "capacity_seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "ended", default: false
    t.string "vessel_id"
    t.string "port_destination_country"
    t.string "port_origin_country"
    t.string "trip_id"
    t.datetime "load_ins_time"
    t.string "load_ins_job_id"
    t.datetime "end_ins_time"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
