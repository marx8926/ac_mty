class Miembro < ActiveRecord::Base
	has_many :nivel_liderazgos
	belongs_to :persona
	has_many :persona_grupo_principals
	has_many :persona_consolidadors
	has_one :maestro
end
