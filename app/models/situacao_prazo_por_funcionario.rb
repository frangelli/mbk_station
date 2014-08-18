#encoding: utf-8
class SituacaoPrazoPorFuncionario < ActiveRecord::Base
  after_initialize :default_values

  attr_accessible :funcionario, :funcionario_id, :pendente, :realizado, :reanotado, :nao_coube, :dia, :created_at, :legal

  belongs_to :funcionario



  scope :legais, -> {where(legal: 1)}
  scope :administrativos, -> {where(legal: 0)}

  def self.limpar_dia dia
    delete_all(dia: dia)
  end


  def self.find_or_create funcionario_nome_percept, legal, dia
    funcionario = Funcionario.find_by_nome_percept(funcionario_nome_percept)
    unless funcionario
      raise "Funcionário com nome_percept #{count.responsavel} não encontrado. Favor cadastrar"
    end

    prazoPorFuncionario = where(funcionario_id: funcionario.id, legal: legal, dia: dia).first
    unless prazoPorFuncionario
      prazoPorFuncionario = new funcionario_id: funcionario.id, legal: legal, dia: dia
    end

    prazoPorFuncionario
  end

  def self.import_data_from_percept(dia = nil)
  	dia = Date.today unless dia

  	Percept::AgendaPrazo.import_prazos_situacao_por_responsavel_no_dia(dia)
  end


  def self.dados_por_periodo(start_date,end_date,grupo = Funcionario::GRUPO_ADVOGADOS)
  	start_date = Date.today unless start_date
  	end_date = Date.today unless end_date

  	start_date = start_date.beginning_of_day
	  end_date = end_date.end_of_day

    legal = grupo == Funcionario::GRUPO_ADVOGADOS ? 1 : 0

  	select("funcionario_id, SUM(pendente) as pendente, SUM(realizado) as realizado, SUM(reanotado) as reanotado, SUM(nao_coube) as nao_coube")
  	.where("funcionario_id IN (?) AND dia BETWEEN ? AND ? AND legal = ?",Funcionario.where(grupo:grupo).pluck(:id),start_date,end_date,legal)
  	.group("funcionario_id")
  end

  private
    def default_values
      self.pendente ||= 0
      self.realizado ||= 0
      self.reanotado ||= 0
      self.nao_coube ||= 0
    end


end
