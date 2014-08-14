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

ActiveRecord::Schema.define(:version => 20140814183144) do

  create_table "funcionarios", :force => true do |t|
    t.string   "nome"
    t.string   "grupo"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "nome_percept"
    t.integer  "ativo",        :default => 1
  end

  create_table "situacao_intimacoes_dia", :force => true do |t|
    t.date     "dia"
    t.integer  "nao_classificadas"
    t.integer  "classificadas"
    t.integer  "lancadas"
    t.integer  "lixeira"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "situacao_prazo_por_funcionarios", :force => true do |t|
    t.integer  "pendente"
    t.integer  "realizado"
    t.integer  "reanotado"
    t.date     "dia"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "funcionario_id"
    t.integer  "nao_coube"
  end

end
