class HerramConsoConsolidador < ActiveRecord::Base
	belongs_to :persona_consolidador
	belongs_to :herramienta_consolidacion
end
