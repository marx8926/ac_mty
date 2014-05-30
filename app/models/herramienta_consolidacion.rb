class HerramientaConsolidacion < ActiveRecord::Base
	has_many :herram_conso_consolidador
	has_many :lista_temas
end
