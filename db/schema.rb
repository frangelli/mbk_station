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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140707193641) do

  create_table "authorities", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.integer  "remote_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "clientes", :force => true do |t|
    t.string   "nome",       :limit => 100, :null => false
    t.string   "descricao"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "remote_id"
  end

  create_table "funcionarios", :force => true do |t|
    t.string   "nome"
    t.string   "grupo"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "nome_percept"
    t.integer  "ativo",        :default => 1
  end

  create_table "options", :force => true do |t|
    t.string   "option_name"
    t.string   "option_value"
    t.string   "option_description"
    t.integer  "unidade_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "option_display_name"
    t.string   "option_value_type"
  end

  add_index "options", ["unidade_id"], :name => "index_options_on_unidade_id"

  create_table "situacao_prazo_por_funcionarios", :force => true do |t|
    t.integer  "pendente"
    t.integer  "realizado"
    t.integer  "reanotado"
    t.date     "dia"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "funcionario_id"
  end

  create_table "unidades", :force => true do |t|
    t.string   "nome",       :limit => 100, :null => false
    t.string   "descricao"
    t.integer  "cliente_id",                :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "remote_id"
  end

  add_index "unidades", ["cliente_id"], :name => "index_unidades_on_cliente_id"

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "unidade_id"
    t.string   "email"
    t.integer  "authority_id"
  end

  add_index "users", ["authority_id"], :name => "index_users_on_authority_id"
  add_index "users", ["unidade_id"], :name => "index_users_on_unidade_id"

end
