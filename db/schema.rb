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

ActiveRecord::Schema.define(version: 20160302044751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "body_sections", force: :cascade do |t|
    t.integer  "book_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "name"
    t.integer  "row_order"
  end

  add_index "body_sections", ["book_id"], name: "index_body_sections_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "books", ["project_id"], name: "index_books_on_project_id", using: :btree

  create_table "covers", force: :cascade do |t|
    t.text     "photographer"
    t.text     "license"
    t.integer  "project_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "covers", ["project_id"], name: "index_covers_on_project_id", using: :btree

  create_table "description_parameters", force: :cascade do |t|
    t.integer  "description_id"
    t.text     "name"
    t.text     "value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "description_parameters", ["description_id"], name: "index_description_parameters_on_description_id", using: :btree

  create_table "descriptions", force: :cascade do |t|
    t.integer  "project_id"
    t.text     "template"
    t.text     "content"
    t.text     "chapter_list"
    t.text     "excerpt"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "descriptions", ["project_id"], name: "index_descriptions_on_project_id", using: :btree

  create_table "filled_liquid_template_parameters", force: :cascade do |t|
    t.integer  "filled_liquid_template_id"
    t.text     "name"
    t.text     "value"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "filled_liquid_template_parameters", ["filled_liquid_template_id"], name: "index_fl_template_parameters_on_fl_template_id", using: :btree

  create_table "filled_liquid_templates", force: :cascade do |t|
    t.integer  "filled_liquid_templatable_id"
    t.string   "filled_liquid_templatable_type"
    t.text     "content"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "filled_liquid_templates", ["filled_liquid_templatable_type", "filled_liquid_templatable_id"], name: "index_fl_templates_on_fl_templatable_type_and_fl_templatable_id", using: :btree

  create_table "front_sections", force: :cascade do |t|
    t.integer  "book_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "front_sections", ["book_id"], name: "index_front_sections_on_book_id", using: :btree

  create_table "liquid_template_parameters", force: :cascade do |t|
    t.integer  "liquid_template_id"
    t.text     "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "liquid_template_parameters", ["liquid_template_id"], name: "index_liquid_template_parameters_on_liquid_template_id", using: :btree

  create_table "liquid_templates", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "name"
    t.integer  "template_type", default: 0
  end

  add_index "liquid_templates", ["user_id"], name: "index_liquid_templates_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.text     "title"
    t.text     "subtitle"
    t.text     "author"
    t.text     "keywords"
    t.text     "isbn10"
    t.text     "isbn13"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "section_parameters", force: :cascade do |t|
    t.integer  "body_section_id"
    t.text     "name"
    t.text     "value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "front_section_id"
    t.integer  "toc_section_id"
  end

  add_index "section_parameters", ["body_section_id"], name: "index_section_parameters_on_body_section_id", using: :btree
  add_index "section_parameters", ["front_section_id"], name: "index_section_parameters_on_front_section_id", using: :btree
  add_index "section_parameters", ["toc_section_id"], name: "index_section_parameters_on_toc_section_id", using: :btree

  create_table "toc_sections", force: :cascade do |t|
    t.integer  "book_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "toc_sections", ["book_id"], name: "index_toc_sections_on_book_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "body_sections", "books"
  add_foreign_key "books", "projects"
  add_foreign_key "covers", "projects"
  add_foreign_key "description_parameters", "descriptions"
  add_foreign_key "descriptions", "projects"
  add_foreign_key "filled_liquid_template_parameters", "filled_liquid_templates"
  add_foreign_key "front_sections", "books"
  add_foreign_key "liquid_template_parameters", "liquid_templates"
  add_foreign_key "liquid_templates", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "section_parameters", "body_sections"
  add_foreign_key "section_parameters", "front_sections"
  add_foreign_key "section_parameters", "toc_sections"
  add_foreign_key "toc_sections", "books"
end
