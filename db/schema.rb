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

ActiveRecord::Schema.define(version: 2019_06_06_235518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aluguels", force: :cascade do |t|
    t.string "periodo"
    t.string "data_vencimento"
    t.string "previsao_pagamento"
    t.decimal "valor_aluguel"
    t.decimal "multa"
    t.decimal "juros"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "entrega_id"
    t.index ["entrega_id"], name: "index_aluguels_on_entrega_id"
  end

  create_table "conta", force: :cascade do |t|
    t.string "cadastro"
    t.string "referencia"
    t.string "vencimento"
    t.decimal "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tipo_contum_id"
    t.bigint "entrega_id"
    t.index ["entrega_id"], name: "index_conta_on_entrega_id"
    t.index ["tipo_contum_id"], name: "index_conta_on_tipo_contum_id"
  end

  create_table "entregas", force: :cascade do |t|
    t.string "nome"
    t.string "endereco"
    t.string "processo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "implemento"
    t.decimal "multa"
    t.decimal "condominio"
    t.decimal "encargos"
    t.decimal "debito_diversos"
    t.decimal "credito"
    t.decimal "caucao"
    t.boolean "situacao", default: false
  end

  create_table "reparos", force: :cascade do |t|
    t.string "descricao"
    t.decimal "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "entrega_id"
    t.index ["entrega_id"], name: "index_reparos_on_entrega_id"
  end

  create_table "tipo_conta", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "aluguels", "entregas"
  add_foreign_key "conta", "entregas"
  add_foreign_key "conta", "tipo_conta"
  add_foreign_key "reparos", "entregas"
end
