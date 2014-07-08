class Funcionario < ActiveRecord::Base
  before_save :default_values

  default_scope where(:ativo => true)

  attr_accessible :grupo, :nome, :nome_percept, :ativo

  validates_uniqueness_of :nome

  GRUPO_ADVOGADOS = "Advogados"
  GRUPO_ADM = "Administrativo"

  def self.reload_advogados_from_percept
		Percept::AgendaPrazo.responsaveis_com_prazo_legal.each do |nome|
			item = Funcionario.where(nome_percept: nome).first

			if item
				item.grupo = GRUPO_ADVOGADOS
				item.save
			else
				Funcionario.create(nome: nome, nome_percept: nome, grupo: GRUPO_ADVOGADOS)
			end
		end
	end

	def self.reload_administrativos_from_percept
		Percept::AgendaPrazo.responsaveis_sem_prazo_legal.each do |nome|
			item = Funcionario.where(nome_percept: nome).first

			if item
				item.grupo = GRUPO_ADM
				item.save
			else
				Funcionario.create(nome: nome, nome_percept: nome, grupo: GRUPO_ADM)
			end
		end
	end

  def to_s
    nome
  end

	def self.import_data_from_percept
		reload_advogados_from_percept
		reload_administrativos_from_percept
	end

  def default_values
    self.status ||= 1
  end
end
