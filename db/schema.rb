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

ActiveRecord::Schema.define(version: 20160215025417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coursepage_materials", force: :cascade do |t|
    t.string   "title",         null: false
    t.string   "description",   null: false
    t.string   "material_type", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "course_id"
  end

  add_index "coursepage_materials", ["course_id"], name: "index_coursepage_materials_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "coursenumber",                  null: false
    t.string   "title",                         null: false
    t.string   "description",                   null: false
    t.date     "start_date",                    null: false
    t.date     "end_date",                      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "status",        default: false
    t.integer  "instructor_id"
  end

  add_index "courses", ["instructor_id"], name: "index_courses_on_instructor_id", using: :btree

  create_table "enrollment_requests", force: :cascade do |t|
    t.boolean  "finished",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "student_id"
    t.integer  "course_id"
  end

  add_index "enrollment_requests", ["course_id"], name: "index_enrollment_requests_on_course_id", using: :btree
  add_index "enrollment_requests", ["student_id"], name: "index_enrollment_requests_on_student_id", using: :btree

  create_table "histories", force: :cascade do |t|
    t.string   "role",       null: false
    t.string   "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "course_id"
  end

  add_index "histories", ["course_id"], name: "index_histories_on_course_id", using: :btree
  add_index "histories", ["user_id"], name: "index_histories_on_user_id", using: :btree

  create_table "student_enrollments", force: :cascade do |t|
    t.string   "status",                   null: false
    t.string   "grade",      default: "0"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "student_id"
    t.integer  "course_id"
  end

  add_index "student_enrollments", ["course_id"], name: "index_student_enrollments_on_course_id", using: :btree
  add_index "student_enrollments", ["student_id"], name: "index_student_enrollments_on_student_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "email",                          null: false
    t.string   "password_digest"
    t.string   "type"
    t.boolean  "deletable",       default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "coursepage_materials", "courses"
  add_foreign_key "courses", "users", column: "instructor_id"
  add_foreign_key "enrollment_requests", "courses"
  add_foreign_key "enrollment_requests", "users", column: "student_id"
  add_foreign_key "histories", "courses"
  add_foreign_key "histories", "users"
  add_foreign_key "student_enrollments", "courses"
  add_foreign_key "student_enrollments", "users", column: "student_id"
end
