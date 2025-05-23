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

ActiveRecord::Schema[7.0].define(version: 2025_04_22_201619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "interval_type", ["day", "week", "month", "year"]
  create_enum "inventory", ["trackable", "infinite"]
  create_enum "question_type", ["open_question", "choose_one", "multiple_select"]
  create_enum "status", ["pending", "processed", "failed", "fulfilled", "refunded"]

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "postal"
    t.boolean "address_check"
    t.bigint "customer_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["customer_order_id"], name: "index_addresses_on_customer_order_id"
  end

  create_table "answer_options", force: :cascade do |t|
    t.text "answer_text"
    t.integer "value"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answer_options_on_question_id"
  end

  create_table "artifacts", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "image"
    t.bigint "category_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embed"
    t.datetime "artifact_date"
    t.bigint "survey_id"
    t.index ["category_id"], name: "index_artifacts_on_category_id"
    t.index ["survey_id"], name: "index_artifacts_on_survey_id"
  end

  create_table "artifacts_posts", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "artifact_id", null: false
    t.index ["artifact_id"], name: "index_artifacts_posts_on_artifact_id"
    t.index ["post_id"], name: "index_artifacts_posts_on_post_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaigns_customers", id: false, force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaigns_customers_on_campaign_id"
    t.index ["customer_id"], name: "index_campaigns_customers_on_customer_id"
  end

  create_table "campaigns_emails", id: false, force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "email_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaigns_emails_on_campaign_id"
    t.index ["email_id"], name: "index_campaigns_emails_on_email_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "image"
    t.integer "parent_id"
    t.integer "row_order"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "customer_emails", force: :cascade do |t|
    t.bigint "email_id", null: false
    t.bigint "customer_id", null: false
    t.boolean "email_sent"
    t.datetime "sent_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_emails_on_customer_id"
    t.index ["email_id"], name: "index_customer_emails_on_email_id"
  end

  create_table "customer_orders", force: :cascade do |t|
    t.string "guid"
    t.string "stripe_id"
    t.decimal "amount"
    t.decimal "fee"
    t.decimal "net"
    t.text "description"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "order_status", default: "pending", enum_type: "status"
    t.bigint "customer_id"
    t.string "stripe_checkout_id"
    t.boolean "receipt_sent"
    t.datetime "receipt_sent_date"
    t.string "subscription_id"
    t.index ["customer_id"], name: "index_customer_orders_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "stripe_id"
    t.boolean "promotion_consent"
  end

  create_table "email_verification_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_email_verification_tokens_on_user_id"
  end

  create_table "emails", force: :cascade do |t|
    t.datetime "date_sent"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "orderables", force: :cascade do |t|
    t.bigint "variation_id", null: false
    t.bigint "cart_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_order_id"
    t.index ["cart_id"], name: "index_orderables_on_cart_id"
    t.index ["customer_order_id"], name: "index_orderables_on_customer_order_id"
    t.index ["variation_id"], name: "index_orderables_on_variation_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.boolean "nav"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "password_reset_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_password_reset_tokens_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "stripe_id"
    t.string "last_4"
    t.bigint "customer_order_id", null: false
    t.boolean "cvc_check"
    t.string "card_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_order_id"], name: "index_payment_methods_on_customer_order_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.string "image"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.string "markdown"
    t.string "html_text"
    t.datetime "pub_date"
    t.integer "pub_order"
    t.index ["category_id"], name: "index_posts_on_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "row_order"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "stripe_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "question_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "answer_option_ids"
    t.text "answer_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "survey_response_id", null: false
    t.index ["question_id"], name: "index_question_answers_on_question_id"
    t.index ["survey_response_id"], name: "index_question_answers_on_survey_response_id"
  end

  create_table "questions", force: :cascade do |t|
    t.enum "question_type", default: "choose_one", enum_type: "question_type"
    t.text "question_text"
    t.bigint "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "survey_responses", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_survey_responses_on_customer_id"
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "variations", force: :cascade do |t|
    t.string "name"
    t.bigint "product_id", null: false
    t.string "image"
    t.decimal "amount", precision: 10, scale: 2
    t.boolean "active", default: true
    t.boolean "add_on"
    t.integer "count_on_hand", default: 0
    t.integer "unit_quantity"
    t.integer "row_order"
    t.boolean "recurring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "inventory_type", default: "trackable", enum_type: "inventory"
    t.string "stripe_id"
    t.enum "interval", enum_type: "interval_type"
    t.integer "interval_count"
    t.string "slug"
    t.index ["product_id"], name: "index_variations_on_product_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "customer_orders"
  add_foreign_key "answer_options", "questions"
  add_foreign_key "artifacts", "categories"
  add_foreign_key "artifacts", "surveys"
  add_foreign_key "customer_emails", "customers"
  add_foreign_key "customer_emails", "emails"
  add_foreign_key "customer_orders", "customers"
  add_foreign_key "email_verification_tokens", "users"
  add_foreign_key "orderables", "carts"
  add_foreign_key "orderables", "customer_orders"
  add_foreign_key "orderables", "variations"
  add_foreign_key "password_reset_tokens", "users"
  add_foreign_key "payment_methods", "customer_orders"
  add_foreign_key "posts", "categories"
  add_foreign_key "products", "categories"
  add_foreign_key "question_answers", "questions"
  add_foreign_key "question_answers", "survey_responses"
  add_foreign_key "questions", "surveys"
  add_foreign_key "sessions", "users"
  add_foreign_key "survey_responses", "customers"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "variations", "products"
end
