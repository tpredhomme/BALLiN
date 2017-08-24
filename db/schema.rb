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

ActiveRecord::Schema.define(version: 20170824061024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "citext"
  enable_extension "uuid-ossp"

  create_table "administrators", id: :bigserial, force: :cascade do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "email",                                  null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "locale",                 default: "en",  null: false
    t.string   "default_currency",       default: "USD", null: false
    t.index ["confirmation_token"], name: "index_administrators_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_administrators_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true, using: :btree
  end

  create_table "brand_accounts", id: :bigserial, force: :cascade do |t|
    t.string   "name",             limit: 50, default: "",    null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "default_currency", limit: 3,  default: "EUR", null: false
    t.string   "locale",           limit: 5,  default: "en",  null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.string   "saison"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaign_briefs", id: :bigserial, force: :cascade do |t|
    t.integer  "brand_account_id", default: 0,       null: false
    t.integer  "validated_by"
    t.string   "status",           default: "draft", null: false
    t.string   "label",            default: "",      null: false
    t.text     "description"
    t.string   "website"
    t.jsonb    "logo_asset"
    t.jsonb    "cover_asset"
    t.datetime "confirmed_at"
    t.datetime "validated_at"
    t.integer  "users_count_max",  default: 0,       null: false
    t.datetime "created_at"
    t.index ["brand_account_id", "label"], name: "index_campaign_briefs_on_brand_account_id_and_label", using: :btree
    t.index ["status"], name: "index_campaign_briefs_on_status", using: :btree
    t.index ["validated_by"], name: "index_campaign_briefs_on_validated_by", using: :btree
  end

  create_table "campaign_criterias", id: :bigserial, force: :cascade do |t|
    t.integer "segment_id",                 default: 0, null: false
    t.string  "criteria_name"
    t.jsonb   "criteria_values"
    t.string  "mapping",         limit: 50
    t.index ["segment_id"], name: "index_campaign_criterias_on_segment_id", using: :btree
  end

  create_table "campaign_generated_publications", force: :cascade do |t|
    t.integer "selected_user_id",                                             null: false
    t.uuid    "network_publication_id", default: -> { "uuid_generate_v4()" }, null: false
    t.integer "user_account_id",                                              null: false
    t.integer "network_domain_id",                                            null: false
    t.index ["network_domain_id"], name: "index_campaign_generated_publications_on_network_domain_id", using: :btree
    t.index ["network_publication_id"], name: "index_campaign_generated_publications_on_network_publication_id", using: :btree
    t.index ["selected_user_id"], name: "index_campaign_generated_publications_on_selected_user_id", using: :btree
    t.index ["user_account_id"], name: "index_campaign_generated_publications_on_user_account_id", using: :btree
  end

  create_table "campaign_logistic_products", force: :cascade do |t|
    t.integer "logistic_id",                 default: 0,  null: false
    t.string  "label",           limit: 100, default: "", null: false
    t.integer "available_items"
    t.integer "booked_items",                default: 0,  null: false
    t.string  "reference"
    t.integer "items_count",                 default: 1,  null: false
  end

  create_table "campaign_logistic_slots", force: :cascade do |t|
    t.integer  "logistic_id",     default: 0, null: false
    t.integer  "available_items", default: 0, null: false
    t.integer  "booked_items",    default: 0, null: false
    t.integer  "duration"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "location"
    t.integer  "items_count",     default: 1, null: false
  end

  create_table "campaign_logistics", force: :cascade do |t|
    t.integer  "segment_id"
    t.string   "type",         limit: 50, default: "Campaign::Logistic::Shipment", null: false
    t.text     "contact"
    t.text     "explanations"
    t.integer  "guests_count",            default: 0,                              null: false
    t.integer  "duration"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "location"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.index ["segment_id"], name: "index_campaign_logistics_on_segment_id", using: :btree
  end

  create_table "campaign_segments", id: :bigserial, force: :cascade do |t|
    t.integer  "brief_id",                        default: 0,     null: false
    t.integer  "country_id"
    t.string   "label",                           default: "",    null: false
    t.text     "description"
    t.text     "expectations"
    t.jsonb    "expectation_details"
    t.string   "hashtags",                        default: [],                 array: true
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "experience_details"
    t.float    "segment_value"
    t.string   "credits_scope"
    t.float    "credits_value"
    t.text     "credits"
    t.integer  "users_count"
    t.jsonb    "users_statuses",                  default: {},    null: false
    t.boolean  "has_lock",                        default: false, null: false
    t.string   "scopes",                                                       array: true
    t.jsonb    "cash_value"
    t.jsonb    "experience_value"
    t.string   "currency",              limit: 3, default: "EUR", null: false
    t.boolean  "show_logistic_warning",           default: true,  null: false
    t.jsonb    "visual_assets",                   default: {}
    t.index ["brief_id", "label"], name: "index_campaign_segments_on_brief_id_and_label", using: :btree
    t.index ["country_id"], name: "index_campaign_segments_on_country_id", using: :btree
  end

  create_table "campaign_selected_user_logistics", force: :cascade do |t|
    t.integer "selected_user_id"
    t.integer "logistic_slot_id"
    t.integer "product_id"
    t.integer "user_address_id"
    t.string  "guests",                                                                                          array: true
    t.text    "details"
    t.text    "shipment_details"
    t.jsonb   "logistic_details",            default: {},                                           null: false
    t.string  "type",             limit: 50, default: "Campaign::SelectedUser::Logistic::Shipment", null: false
    t.integer "logistic_id"
    t.index ["logistic_id"], name: "index_campaign_selected_user_logistics_on_logistic_id", using: :btree
    t.index ["logistic_slot_id"], name: "index_campaign_selected_user_logistics_on_logistic_slot_id", using: :btree
    t.index ["product_id"], name: "index_campaign_selected_user_logistics_on_product_id", using: :btree
    t.index ["selected_user_id"], name: "index_campaign_selected_user_logistics_on_selected_user_id", using: :btree
    t.index ["user_address_id"], name: "index_campaign_selected_user_logistics_on_user_address_id", using: :btree
  end

  create_table "campaign_selected_users", id: :bigserial, force: :cascade do |t|
    t.integer "segment_id",                     default: 0,         null: false
    t.integer "user_account_id",                default: 0,         null: false
    t.string  "status",              limit: 20, default: "pending", null: false
    t.jsonb   "status_steps",                   default: {},        null: false
    t.text    "note"
    t.boolean "logistic_complete",              default: false,     null: false
    t.jsonb   "expectation_details"
    t.float   "experience_value"
    t.text    "experience_details"
    t.float   "cash_value"
    t.float   "segment_value"
    t.string  "credits_scope"
    t.float   "credits_value"
    t.text    "credits"
    t.text    "deal_details"
    t.string  "refusal",             limit: 10
    t.index ["segment_id", "user_account_id"], name: "unique_selected_user", unique: true, using: :btree
    t.index ["status"], name: "campaign_selected_user_status", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "cities", id: :bigserial, force: :cascade do |t|
    t.bigint   "country_id"
    t.string   "zip_code",   limit: 50, default: "",    null: false
    t.string   "name",       limit: 50, default: "",    null: false
    t.jsonb    "labels",                default: {},    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "main",                  default: false, null: false
    t.index ["country_id"], name: "index_cities_on_country_id", using: :btree
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_message_replies", id: :bigserial, force: :cascade do |t|
    t.string   "staff_name", null: false
    t.text     "content",    null: false
    t.bigint   "message_id", null: false
    t.datetime "sent_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_contact_message_replies_on_message_id", using: :btree
  end

  create_table "contact_message_threads", id: :bigserial, force: :cascade do |t|
    t.integer  "thread_id",      default: 0,  null: false
    t.bigint   "sender_id",                   null: false
    t.string   "sender_type",                 null: false
    t.string   "sender_name",    default: "", null: false
    t.bigint   "recipient_id",                null: false
    t.string   "recipient_type",              null: false
    t.string   "recipient_name", default: "", null: false
    t.text     "content"
    t.datetime "seen_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["recipient_id", "recipient_type"], name: "message_thread_recipient", using: :btree
    t.index ["sender_id", "sender_type"], name: "message_thread_sender", using: :btree
    t.index ["thread_id"], name: "index_contact_message_threads_on_thread_id", using: :btree
  end

  create_table "contact_messages", id: :bigserial, force: :cascade do |t|
    t.string   "first_name", limit: 100
    t.string   "last_name",  limit: 100
    t.string   "email",                                   null: false
    t.string   "phone"
    t.text     "content",                                 null: false
    t.boolean  "has_reply",              default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "flagged",                default: false
    t.datetime "deleted_at"
    t.string   "source",     limit: 20,  default: "user", null: false
    t.string   "company"
    t.string   "job"
  end

  create_table "countries", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.string   "iso"
    t.jsonb    "labels",                     default: {}, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "nationality_id"
    t.string   "postal_regex",   limit: 110
    t.string   "calling_code",   limit: 6
    t.index ["iso"], name: "index_countries_on_iso", unique: true, using: :btree
  end

  create_table "crawler_attachments", force: :cascade do |t|
    t.string   "attached_type",   default: "",                          null: false
    t.uuid     "attached_id",     default: -> { "uuid_generate_v4()" }, null: false
    t.string   "attached_source", default: "",                          null: false
    t.string   "url_source",      default: "",                          null: false
    t.string   "path_name"
    t.datetime "fetched_at"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["attached_id", "attached_type"], name: "index_crawler_attachments_on_attached_id_and_attached_type", using: :btree
    t.index ["attached_type", "attached_id", "attached_source", "url_source"], name: "unique_crawler_attachment", unique: true, using: :btree
    t.index ["fetched_at"], name: "index_crawler_attachments_on_fetched_at", using: :btree
  end

  create_table "crawlers_invalid_records", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "model_klass"
    t.text     "data"
    t.text     "exception_details"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["domain_id"], name: "index_crawlers_invalid_records_on_domain_id", using: :btree
  end

  create_table "crawlers_log_generals", force: :cascade do |t|
    t.string  "crawler_name", default: "", null: false
    t.integer "fetchables",   default: 0,  null: false
    t.integer "started",      default: 0,  null: false
    t.integer "finished",     default: 0,  null: false
    t.date    "created_on",                null: false
    t.index ["crawler_name"], name: "index_crawlers_log_generals_on_crawler_name", using: :btree
  end

  create_table "crawlers_log_individuals", force: :cascade do |t|
    t.string   "crawler_name",           default: "", null: false
    t.integer  "user_account_id",        default: 0,  null: false
    t.integer  "network_access_id",      default: 0,  null: false
    t.datetime "start_at"
    t.integer  "user_account_duration"
    t.integer  "feed_duration"
    t.integer  "relationships_duration"
    t.datetime "end_at"
    t.text     "error_message"
    t.date     "created_on",                          null: false
    t.index ["crawler_name"], name: "index_crawlers_log_individuals_on_crawler_name", using: :btree
    t.index ["network_access_id"], name: "index_crawlers_log_individuals_on_network_access_id", using: :btree
    t.index ["user_account_id"], name: "index_crawlers_log_individuals_on_user_account_id", using: :btree
  end

  create_table "crawlers_log_user_accounts", force: :cascade do |t|
    t.string  "crawler_name",           default: "", null: false
    t.integer "user_account_id",        default: 0,  null: false
    t.integer "network_accesses_count", default: 0,  null: false
    t.integer "total_duration",         default: 0,  null: false
    t.integer "scoring_duration",       default: 0,  null: false
    t.integer "socialcard_duration",    default: 0,  null: false
    t.date    "created_on",                          null: false
    t.index ["crawler_name"], name: "index_crawlers_log_user_accounts_on_crawler_name", using: :btree
    t.index ["user_account_id"], name: "index_crawlers_log_user_accounts_on_user_account_id", using: :btree
  end

  create_table "days", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gamification_successes", force: :cascade do |t|
    t.string "name",      default: "", null: false
    t.jsonb  "labels",    default: {}, null: false
    t.string "category"
    t.string "level",     default: "", null: false
    t.text   "criterias", default: "", null: false
    t.index ["category"], name: "index_gamification_successes_on_category", using: :btree
    t.index ["name"], name: "index_gamification_successes_on_name", unique: true, using: :btree
  end

  create_table "gamification_unlocked_successes", force: :cascade do |t|
    t.integer  "user_account_id", default: 0, null: false
    t.integer  "success_id",      default: 0, null: false
    t.datetime "unlocked_at",                 null: false
    t.index ["user_account_id", "success_id"], name: "unique_unlocked_success", unique: true, using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", id: :bigserial, force: :cascade do |t|
    t.bigint   "inviter_id", null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint   "invitee_id"
    t.string   "message"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id", using: :btree
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nationalities", id: :bigserial, force: :cascade do |t|
    t.string   "name",       null: false
    t.jsonb    "labels"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_nationalities_on_name", unique: true, using: :btree
  end

  create_table "network_accesses", id: :bigserial, force: :cascade do |t|
    t.bigint   "domain_id",                                                                   null: false
    t.string   "access_token"
    t.string   "access_token_secret"
    t.decimal  "raw_score",                          precision: 4, scale: 2, default: "0.0",  null: false
    t.datetime "crawled_at"
    t.datetime "access_token_expires_at"
    t.string   "code"
    t.string   "refresh_token"
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
    t.datetime "next_fetch_at"
    t.datetime "last_fetch_at"
    t.string   "access_type",             limit: 10,                         default: "user", null: false
    t.boolean  "active",                                                     default: true,   null: false
    t.integer  "reach",                                                      default: 0,      null: false
    t.float    "engagement",                                                 default: 0.0,    null: false
    t.string   "owner_type",              limit: 20,                         default: "",     null: false
    t.integer  "owner_id",                                                   default: 0,      null: false
    t.index ["access_token_expires_at"], name: "index_network_accesses_on_access_token_expires_at", using: :btree
    t.index ["domain_id"], name: "index_network_accesses_on_domain_id", using: :btree
    t.index ["owner_type", "owner_id"], name: "index_network_accesses_on_owner_type_and_owner_id", using: :btree
  end

  create_table "network_account_counters", id: :bigserial, force: :cascade do |t|
    t.uuid    "account_id",          default: -> { "uuid_generate_v4()" }
    t.integer "engagement",          default: 0,                           null: false
    t.integer "shares_count",        default: 0,                           null: false
    t.integer "likes_count",         default: 0,                           null: false
    t.integer "dislikes_count",      default: 0,                           null: false
    t.integer "views_count",         default: 0,                           null: false
    t.integer "comments_count",      default: 0,                           null: false
    t.integer "publications_count",  default: 0,                           null: false
    t.integer "subscriptions_count", default: 0,                           null: false
    t.integer "followers_count",     default: 0,                           null: false
    t.integer "friends_count",       default: 0,                           null: false
    t.date    "created_on",                                                null: false
    t.integer "reach",               default: 0,                           null: false
    t.index ["account_id", "created_on"], name: "unique_network_account_counters", unique: true, using: :btree
    t.index ["account_id"], name: "index_network_account_counters_on_account_id", using: :btree
    t.index ["created_on"], name: "index_network_account_counters_on_created_on", using: :btree
    t.index ["engagement"], name: "index_network_account_counters_on_engagement", using: :btree
  end

  create_table "network_account_fans", id: :bigserial, force: :cascade do |t|
    t.uuid    "account_id",     default: -> { "uuid_generate_v4()" }
    t.uuid    "fan_id",         default: -> { "uuid_generate_v4()" }
    t.integer "engagement",     default: 0,                           null: false
    t.integer "shares_count",   default: 0,                           null: false
    t.integer "likes_count",    default: 0,                           null: false
    t.integer "dislikes_count", default: 0,                           null: false
    t.integer "comments_count", default: 0,                           null: false
    t.date    "created_on",     default: '2017-04-21',                null: false
    t.index ["account_id", "fan_id", "created_on"], name: "unique_network_account_fans", unique: true, using: :btree
    t.index ["account_id"], name: "index_network_account_fans_on_account_id", using: :btree
    t.index ["engagement"], name: "index_network_account_fans_on_engagement", using: :btree
    t.index ["fan_id"], name: "index_network_account_fans_on_fan_id", using: :btree
  end

  create_table "network_account_feeds", id: :bigserial, force: :cascade do |t|
    t.bigint   "feed_id",                                             null: false
    t.uuid     "account_id",    default: -> { "uuid_generate_v4()" }
    t.string   "cursors",                                             null: false, array: true
    t.datetime "next_fetch_at", default: '1970-01-01 00:00:00',       null: false
    t.datetime "last_fetch_at", default: '1970-01-01 00:00:00',       null: false
    t.index ["account_id"], name: "index_network_account_feeds_on_account_id", using: :btree
    t.index ["feed_id", "account_id"], name: "index_network_account_feeds_on_feed_id_and_account_id", unique: true, using: :btree
  end

  create_table "network_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.bigint   "access_id"
    t.bigint   "domain_id",                                                             null: false
    t.string   "origin_id",           limit: 40,  default: "",                          null: false
    t.bigint   "gender_id"
    t.string   "type",                limit: 30,  default: "Network::Account::Profile", null: false
    t.string   "profile_picture"
    t.string   "profile_link",        limit: 200
    t.string   "email",               limit: 100
    t.string   "username",            limit: 100
    t.string   "name",                limit: 100
    t.jsonb    "names"
    t.text     "bio"
    t.string   "locale",              limit: 5
    t.string   "timezone",            limit: 50
    t.date     "birthdate"
    t.float    "geocode",                                                                            array: true
    t.integer  "publications_count",              default: 0,                           null: false
    t.integer  "subscriptions_count",             default: 0,                           null: false
    t.integer  "followers_count",                 default: 0,                           null: false
    t.integer  "friends_count",                   default: 0,                           null: false
    t.jsonb    "extras"
    t.datetime "next_fetch_at",                   default: '1970-01-01 00:00:00',       null: false
    t.datetime "last_fetch_at",                   default: '1970-01-01 00:00:00',       null: false
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.integer  "reach",                           default: 0,                           null: false
    t.index ["access_id"], name: "index_network_accounts_on_access_id", unique: true, using: :btree
    t.index ["domain_id", "origin_id"], name: "index_network_accounts_on_domain_id_and_origin_id", unique: true, using: :btree
  end

  create_table "network_api_feeds", id: :bigserial, force: :cascade do |t|
    t.bigint   "domain_id",                    null: false
    t.string   "version",         default: "", null: false
    t.integer  "rate_window"
    t.integer  "max_count"
    t.integer  "calls_remaining", default: 0,  null: false
    t.datetime "next_fetch_at"
  end

  create_table "network_apis", id: :bigserial, force: :cascade do |t|
    t.bigint   "domain_id",                       null: false
    t.string   "version",          default: "",   null: false
    t.integer  "rate_window"
    t.integer  "max_count"
    t.integer  "calls_remaining",  default: 0,    null: false
    t.datetime "next_fetch_at"
    t.jsonb    "endpoint_details", default: "{}"
  end

  create_table "network_comments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "account_id",                 default: -> { "uuid_generate_v4()" }
    t.uuid     "publication_id",             default: -> { "uuid_generate_v4()" }
    t.text     "origin_id",                  default: "",                          null: false
    t.bigint   "domain_id",                                                        null: false
    t.integer  "parent"
    t.string   "kind",            limit: 15, default: "text",                      null: false
    t.text     "content"
    t.string   "media_id",        limit: 40
    t.jsonb    "media_details"
    t.integer  "engagement",                 default: 0,                           null: false
    t.integer  "reach",                      default: 0,                           null: false
    t.integer  "shares_count",               default: 0,                           null: false
    t.integer  "likes_count",                default: 0,                           null: false
    t.integer  "dislikes_count",             default: 0,                           null: false
    t.integer  "views_count",                default: 0,                           null: false
    t.integer  "comments_count",             default: 0,                           null: false
    t.datetime "deleted_at"
    t.string   "tags",                                                                          array: true
    t.uuid     "tagged_accounts",                                                               array: true
    t.datetime "posted_at",                  default: '1970-01-01 00:00:00',       null: false
    t.jsonb    "extras"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.datetime "last_fetch_at"
    t.string   "locale",          limit: 5
    t.index ["account_id"], name: "index_network_comments_on_account_id", using: :btree
    t.index ["domain_id", "origin_id"], name: "index_network_comments_on_domain_id_and_origin_id", unique: true, using: :btree
    t.index ["publication_id"], name: "index_network_comments_on_publication_id", using: :btree
  end

  create_table "network_domains", id: :bigserial, force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.boolean  "active",                          default: false
    t.boolean  "user_pictures",                   default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "color",                 limit: 6, default: "ffffff"
    t.boolean  "fetch_likes",                     default: false,    null: false
    t.boolean  "support_likes",                   default: false,    null: false
    t.boolean  "fetch_dislikes",                  default: false,    null: false
    t.boolean  "support_dislikes",                default: false,    null: false
    t.boolean  "fetch_shares",                    default: false,    null: false
    t.boolean  "support_shares",                  default: false,    null: false
    t.boolean  "fetch_comments",                  default: false,    null: false
    t.boolean  "support_comments",                default: false,    null: false
    t.boolean  "fetch_relationships",             default: false,    null: false
    t.boolean  "support_relationships",           default: false,    null: false
    t.boolean  "support_friends",                 default: false,    null: false
    t.boolean  "support_views",                   default: false,    null: false
    t.jsonb    "extras",                          default: "{}",     null: false
    t.index ["tag"], name: "index_network_domains_on_tag", unique: true, using: :btree
  end

  create_table "network_engagements", id: :bigserial, force: :cascade do |t|
    t.uuid    "account_id",     default: -> { "uuid_generate_v4()" }
    t.uuid    "publication_id", default: -> { "uuid_generate_v4()" }
    t.integer "engagement",     default: 0,                           null: false
    t.integer "shares_count",   default: 0,                           null: false
    t.integer "likes_count",    default: 0,                           null: false
    t.integer "dislikes_count", default: 0,                           null: false
    t.integer "views_count",    default: 0,                           null: false
    t.integer "comments_count", default: 0,                           null: false
    t.date    "created_on",                                           null: false
    t.index ["account_id", "publication_id", "created_on"], name: "unique_network_publication_engagment", unique: true, using: :btree
    t.index ["account_id"], name: "index_network_engagements_on_account_id", using: :btree
    t.index ["created_on"], name: "index_network_engagements_on_created_on", using: :btree
    t.index ["engagement"], name: "index_network_engagements_on_engagement", using: :btree
    t.index ["publication_id"], name: "index_network_engagements_on_publication_id", using: :btree
  end

  create_table "network_feeds", id: :bigserial, force: :cascade do |t|
    t.bigint   "domain_id",                                       null: false
    t.string   "label",           default: "",                    null: false
    t.boolean  "rate_limited",    default: false,                 null: false
    t.integer  "max_count"
    t.integer  "rate_window"
    t.integer  "calls_remaining", default: 0,                     null: false
    t.datetime "next_fetch_at",   default: '1970-01-01 00:00:00', null: false
  end

  create_table "network_hashtags", id: :bigserial, force: :cascade do |t|
    t.string "tag", default: "", null: false
    t.index ["tag"], name: "index_network_hashtags_on_tag", unique: true, using: :btree
  end

  create_table "network_publication_hashtags", id: false, force: :cascade do |t|
    t.uuid   "publication_id", default: -> { "uuid_generate_v4()" }
    t.bigint "hashtag_id",     default: 0,                           null: false
    t.index ["publication_id", "hashtag_id"], name: "unique_publication_hashtag", unique: true, using: :btree
    t.index ["publication_id"], name: "index_network_publication_hashtags_on_publication_id", using: :btree
  end

  create_table "network_publication_likes", force: :cascade do |t|
    t.uuid     "account_id",     default: -> { "uuid_generate_v4()" }, null: false
    t.datetime "created_at",                                           null: false
    t.uuid     "publication_id", default: -> { "uuid_generate_v4()" }, null: false
    t.index ["account_id", "publication_id"], name: "publication_unique_like", unique: true, using: :btree
  end

  create_table "network_publication_shares", force: :cascade do |t|
    t.uuid     "account_id",     default: -> { "uuid_generate_v4()" }, null: false
    t.datetime "created_at",                                           null: false
    t.uuid     "publication_id", default: -> { "uuid_generate_v4()" }, null: false
    t.index ["account_id", "publication_id"], name: "publication_unique_share", unique: true, using: :btree
  end

  create_table "network_publications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "account_id",                  default: -> { "uuid_generate_v4()" }
    t.bigint   "domain_id",                                                         null: false
    t.string   "origin_id",       limit: 40,  default: "",                          null: false
    t.uuid     "related"
    t.string   "related_as",      limit: 20
    t.string   "kind",            limit: 15,  default: "text",                      null: false
    t.string   "tags",                                                                           array: true
    t.string   "locale",          limit: 5
    t.string   "privacy",         limit: 50
    t.string   "title"
    t.text     "content"
    t.uuid     "tagged_accounts",                                                                array: true
    t.string   "link"
    t.jsonb    "link_details"
    t.string   "media_id",        limit: 100
    t.jsonb    "media_details"
    t.float    "geocode",                                                                        array: true
    t.integer  "engagement",                  default: 0,                           null: false
    t.integer  "shares_count",                default: 0,                           null: false
    t.integer  "likes_count",                 default: 0,                           null: false
    t.integer  "dislikes_count",              default: 0,                           null: false
    t.integer  "views_count",                 default: 0,                           null: false
    t.integer  "comments_count",              default: 0,                           null: false
    t.datetime "deleted_at"
    t.datetime "posted_at"
    t.datetime "next_fetch_at",               default: '1970-01-01 00:00:00',       null: false
    t.datetime "last_fetch_at",               default: '1970-01-01 00:00:00',       null: false
    t.jsonb    "extras"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.date     "posted_on",                                                         null: false
    t.index ["account_id"], name: "index_network_publications_on_account_id", using: :btree
    t.index ["domain_id", "origin_id"], name: "index_network_publications_on_domain_id_and_origin_id", unique: true, using: :btree
    t.index ["related"], name: "index_network_publications_on_related", using: :btree
  end

  create_table "network_relationship_logs", id: :bigserial, force: :cascade do |t|
    t.uuid    "account_id", default: -> { "uuid_generate_v4()" }
    t.integer "add",        default: 1,                           null: false
    t.uuid    "subject_id", default: -> { "uuid_generate_v4()" }
    t.date    "created_on",                                       null: false
    t.index ["account_id", "subject_id", "created_on"], name: "unique_network_relationship_log", unique: true, using: :btree
    t.index ["account_id"], name: "index_network_relationship_logs_on_account_id", using: :btree
    t.index ["created_on"], name: "index_network_relationship_logs_on_created_on", using: :btree
    t.index ["subject_id"], name: "index_network_relationship_logs_on_subject_id", using: :btree
  end

  create_table "network_relationship_versions", force: :cascade do |t|
    t.uuid   "account_id", default: -> { "uuid_generate_v4()" }
    t.uuid   "subject_id", default: -> { "uuid_generate_v4()" }
    t.string "kind",       default: "",                          null: false
  end

  create_table "network_relationships", id: :bigserial, force: :cascade do |t|
    t.uuid   "account_id", default: -> { "uuid_generate_v4()" }
    t.uuid   "subject_id", default: -> { "uuid_generate_v4()" }
    t.string "kind",       default: "",                          null: false
    t.index ["account_id", "subject_id", "kind"], name: "unique_network_relationship", unique: true, using: :btree
    t.index ["account_id"], name: "index_network_relationships_on_account_id", using: :btree
    t.index ["subject_id"], name: "index_network_relationships_on_subject_id", using: :btree
  end

  create_table "oauth_access_grants", id: :bigserial, force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", id: :bigserial, force: :cascade do |t|
    t.bigint   "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", id: :bigserial, force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.integer  "club_id"
    t.integer  "team_id"
    t.index ["club_id"], name: "index_players_on_club_id", using: :btree
    t.index ["email"], name: "index_players_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree
    t.index ["team_id"], name: "index_players_on_team_id", using: :btree
  end

  create_table "taxonomies", id: :bigserial, force: :cascade do |t|
    t.string   "type",       limit: 64, default: "", null: false
    t.string   "tag",        limit: 64, default: "", null: false
    t.integer  "parent_id"
    t.jsonb    "labels"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["type", "tag"], name: "index_taxonomies_on_type_and_tag", unique: true, using: :btree
  end

  create_table "taxonomies_user_accounts", id: false, force: :cascade do |t|
    t.integer "user_account_id", null: false
    t.integer "taxonomy_id",     null: false
    t.index ["user_account_id", "taxonomy_id"], name: "unique_tua", unique: true, using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "club_id"
    t.integer  "category_id"
    t.integer  "level_id"
    t.integer  "division_id"
    t.integer  "group_id"
    t.integer  "game_id"
    t.integer  "league_id"
    t.index ["category_id"], name: "index_teams_on_category_id", using: :btree
    t.index ["club_id"], name: "index_teams_on_club_id", using: :btree
    t.index ["division_id"], name: "index_teams_on_division_id", using: :btree
    t.index ["game_id"], name: "index_teams_on_game_id", using: :btree
    t.index ["group_id"], name: "index_teams_on_group_id", using: :btree
    t.index ["league_id"], name: "index_teams_on_league_id", using: :btree
    t.index ["level_id"], name: "index_teams_on_level_id", using: :btree
  end

  create_table "tracker_emails", force: :cascade do |t|
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.string   "email"
    t.string   "format",              limit: 60, default: "", null: false
    t.datetime "seen_at"
    t.datetime "clicked_at"
    t.jsonb    "clicked_links",                  default: []
    t.integer  "clicked_links_count",            default: 0,  null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["recipient_type", "recipient_id"], name: "index_tracker_emails_on_recipient_type_and_recipient_id", using: :btree
  end

  create_table "user_accounts", id: :bigserial, force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "city"
    t.datetime "birthday"
    t.integer  "children_count_id"
    t.string   "postal_code"
    t.string   "job_position"
    t.string   "job_company_name"
    t.decimal  "score",                              precision: 10, scale: 6, default: "0.0", null: false
    t.string   "other_activity"
    t.integer  "country_id"
    t.integer  "city_id"
    t.integer  "marital_status_id"
    t.integer  "gender_id"
    t.integer  "clothing_personality_id"
    t.integer  "income_range_id"
    t.integer  "job_id"
    t.integer  "job_activity_sector_id"
    t.text     "bio"
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
    t.integer  "nationality_id"
    t.string   "username"
    t.string   "encrypted_password",                                          default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "access_token",            limit: 64,                          default: "",    null: false
    t.jsonb    "extras"
    t.integer  "reputation_id"
    t.string   "locale",                  limit: 5,                           default: "en",  null: false
    t.uuid     "social_card_uuid"
    t.string   "unconfirmed_email"
    t.string   "labels",                                                      default: [],                 array: true
    t.float    "completion_rate",                                             default: 0.0,   null: false
    t.jsonb    "metrics",                                                     default: {},    null: false
    t.integer  "height_id"
    t.integer  "shirt_size_id"
    t.integer  "shoe_size_id"
    t.index ["children_count_id"], name: "index_user_accounts_on_children_count_id", using: :btree
    t.index ["city_id"], name: "index_user_accounts_on_city_id", using: :btree
    t.index ["clothing_personality_id"], name: "index_user_accounts_on_clothing_personality_id", using: :btree
    t.index ["confirmation_token"], name: "index_user_accounts_on_confirmation_token", unique: true, using: :btree
    t.index ["country_id"], name: "index_user_accounts_on_country_id", using: :btree
    t.index ["email"], name: "index_user_accounts_on_email", unique: true, using: :btree
    t.index ["gender_id"], name: "index_user_accounts_on_gender_id", using: :btree
    t.index ["income_range_id"], name: "index_user_accounts_on_income_range_id", using: :btree
    t.index ["job_activity_sector_id"], name: "index_user_accounts_on_job_activity_sector_id", using: :btree
    t.index ["job_id"], name: "index_user_accounts_on_job_id", using: :btree
    t.index ["marital_status_id"], name: "index_user_accounts_on_marital_status_id", using: :btree
    t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true, using: :btree
  end

  create_table "user_activities", id: :bigserial, force: :cascade do |t|
    t.bigint "user_account_id",   null: false
    t.bigint "activity_id",       null: false
    t.bigint "network_domain_id", null: false
    t.index ["user_account_id", "activity_id", "network_domain_id"], name: "unique_user_activity", unique: true, using: :btree
  end

  create_table "user_addresses", force: :cascade do |t|
    t.integer "account_id"
    t.integer "country_id"
    t.string  "first_name",   limit: 25, default: "", null: false
    t.string  "last_name",    limit: 25, default: "", null: false
    t.string  "address",                 default: "", null: false
    t.string  "address_more"
    t.string  "zip_code",     limit: 20, default: "", null: false
    t.string  "city",         limit: 60, default: "", null: false
    t.index ["account_id"], name: "index_user_addresses_on_account_id", using: :btree
    t.index ["country_id"], name: "index_user_addresses_on_country_id", using: :btree
  end

  create_table "user_avatars", id: :bigserial, force: :cascade do |t|
    t.bigint  "user_account_id",                 null: false
    t.integer "position",                        null: false
    t.string  "original_url"
    t.boolean "main",            default: false, null: false
    t.jsonb   "avatar_asset"
    t.index ["user_account_id", "position"], name: "index_avatars_on_account_id_and_position", unique: true, using: :btree
    t.index ["user_account_id"], name: "index_avatars_on_account_id", using: :btree
  end

  create_table "user_blogs", id: :bigserial, force: :cascade do |t|
    t.string   "url"
    t.bigint   "user_account_id",               null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "custom_topic",      limit: 50
    t.string   "title_publication", limit: 100
    t.index ["user_account_id", "url"], name: "index_user_blogs_on_account_id_and_url", unique: true, using: :btree
    t.index ["user_account_id"], name: "index_user_blogs_on_account_id", using: :btree
  end

  create_table "user_jobs", force: :cascade do |t|
    t.integer  "user_account_id", null: false
    t.integer  "job_id",          null: false
    t.integer  "leaf_job_id"
    t.string   "which_domain"
    t.string   "which_company"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["job_id"], name: "index_user_jobs_on_job_id", using: :btree
    t.index ["leaf_job_id"], name: "index_user_jobs_on_leaf_job_id", using: :btree
    t.index ["user_account_id", "job_id"], name: "index_user_jobs_on_user_account_id_and_job_id", unique: true, using: :btree
    t.index ["user_account_id"], name: "index_user_jobs_on_user_account_id", using: :btree
  end

  create_table "user_product_kinds", id: :bigserial, force: :cascade do |t|
    t.bigint "user_account_id", null: false
    t.bigint "product_kind_id", null: false
    t.index ["user_account_id", "product_kind_id"], name: "unique_user_product_kind", unique: true, using: :btree
  end

  create_table "user_score_logs", id: :bigserial, force: :cascade do |t|
    t.bigint   "user_account_id",                                          null: false
    t.decimal  "score",           precision: 10, scale: 6, default: "0.0", null: false
    t.jsonb    "domains",                                  default: "{}",  null: false
    t.datetime "created_on",                                               null: false
    t.index ["user_account_id"], name: "index_user_score_logs_on_account_id", using: :btree
  end

  create_table "user_selection_lists", id: :bigserial, force: :cascade do |t|
    t.bigint   "user_account_id", null: false
    t.bigint   "selection_id",    null: false
    t.datetime "created_at",      null: false
    t.index ["selection_id"], name: "index_user_selection_lists_on_selection_id", using: :btree
    t.index ["user_account_id", "selection_id"], name: "index_user_selection_lists_on_account_id_and_selection_id", unique: true, using: :btree
    t.index ["user_account_id"], name: "index_user_selection_lists_on_account_id", using: :btree
  end

  create_table "user_selections", id: :bigserial, force: :cascade do |t|
    t.bigint   "owner_id",                            null: false
    t.string   "owner_type",                          null: false
    t.integer  "privacy",                default: 0,  null: false
    t.string   "name",       limit: 100, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["owner_type", "owner_id"], name: "index_user_selections_on_owner_type_and_owner_id", using: :btree
    t.index ["owner_type"], name: "index_user_selections_on_owner_type", using: :btree
    t.index ["privacy"], name: "index_user_selections_on_privacy", using: :btree
  end

  add_foreign_key "players", "teams"
  add_foreign_key "teams", "categories"
  add_foreign_key "teams", "divisions"
  add_foreign_key "teams", "games"
  add_foreign_key "teams", "groups"
  add_foreign_key "teams", "leagues"
  add_foreign_key "teams", "levels"
end
