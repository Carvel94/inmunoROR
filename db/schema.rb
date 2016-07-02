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

ActiveRecord::Schema.define(version: 20160301233139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrator_configurations", force: :cascade do |t|
    t.string   "nombre"
    t.string   "imagen1"
    t.string   "enlace"
    t.string   "titulo_mensaje"
    t.string   "mensaje"
    t.boolean  "mensaje_visible?"
    t.integer  "usuario_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "administrator_configurations", ["usuario_id"], name: "index_administrator_configurations_on_usuario_id", using: :btree

  create_table "administrator_menu_nivel0_menu_nivel1s", force: :cascade do |t|
    t.string   "titulo"
    t.integer  "tipo"
    t.boolean  "estado"
    t.integer  "posicion"
    t.string   "enlace"
    t.string   "titulo_contenido"
    t.text     "contenido"
    t.string   "imagen_banner"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "administrator_menu_nivel0_id"
  end

  create_table "administrator_menu_nivel0s", force: :cascade do |t|
    t.string   "titulo"
    t.boolean  "tipo"
    t.boolean  "estado"
    t.integer  "posicion"
    t.integer  "cantidad"
    t.string   "enlace"
    t.string   "titulo_contenido"
    t.text     "contenido"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "contactos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "email"
    t.text     "mensaje"
    t.text     "respuesta"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "telefono_local"
    t.string   "telefono_celular"
  end

  create_table "faqs", force: :cascade do |t|
    t.string   "pregunta"
    t.text     "respuesta"
    t.integer  "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "faqs", ["usuario_id"], name: "index_faqs_on_usuario_id", using: :btree

  create_table "mensajes", force: :cascade do |t|
    t.string   "nombre"
    t.text     "mensaje"
    t.text     "respuesta"
    t.integer  "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pagos", force: :cascade do |t|
    t.date     "fecha_pago"
    t.integer  "tipo_pago"
    t.string   "numero"
    t.string   "banco"
    t.decimal  "monto"
    t.integer  "usuarios_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tips", force: :cascade do |t|
    t.string   "titulo"
    t.text     "contenido"
    t.string   "tags"
    t.integer  "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tips", ["usuario_id"], name: "index_tips_on_usuario_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
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
    t.string   "username"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "cedula"
    t.string   "numero_excel"
    t.string   "historia"
    t.string   "telefono_habitacion"
    t.string   "telefono_trabajo"
    t.string   "celular1"
    t.string   "celular2"
    t.date     "fecha_nacimiento"
    t.string   "email2"
    t.integer  "estado"
    t.integer  "ava"
    t.integer  "cuc"
    t.integer  "hong"
    t.integer  "berm"
    t.integer  "john"
    t.integer  "asp"
    t.integer  "blom"
    t.integer  "rol"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "fecha_pruebas"
    t.text     "frascos"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", using: :btree
  add_index "usuarios", ["invitation_token"], name: "index_usuarios_on_invitation_token", unique: true, using: :btree
  add_index "usuarios", ["invitations_count"], name: "index_usuarios_on_invitations_count", using: :btree
  add_index "usuarios", ["invited_by_id"], name: "index_usuarios_on_invited_by_id", using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["username"], name: "index_usuarios_on_username", unique: true, using: :btree

  add_foreign_key "administrator_configurations", "usuarios"
  add_foreign_key "administrator_menu_nivel0_menu_nivel1s", "administrator_menu_nivel0s"
  add_foreign_key "faqs", "usuarios"
  add_foreign_key "tips", "usuarios"
end
