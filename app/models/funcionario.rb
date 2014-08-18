class Funcionario < ActiveRecord::Base
  before_save :default_values

  default_scope where(:ativo => true)

  scope :advogados, -> { where(grupo:GRUPO_ADVOGADOS) }
  scope :administrativos, -> {where(grupo:GRUPO_ADM) }

  attr_accessible :grupo, :nome, :nome_percept, :ativo

  validates_uniqueness_of :nome, :nome_percept

  GRUPO_ADVOGADOS = "Advogados"
  GRUPO_ADM = "Administrativo"

  def to_s
    nome
  end

  def default_values
    self.status ||= 1
  end
end
