class GrupoPrincipal < ActiveRecord::Base
	has_many :consolidadors
	has_many :persona_grupo_principals
end
