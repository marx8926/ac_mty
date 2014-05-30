class PersonaConsolidador < ActiveRecord::Base
	belongs_to: miembro
	belongs_to: consolidador
	has_many: herram_conso_consolidadors
end
