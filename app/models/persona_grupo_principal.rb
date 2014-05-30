class PersonaGrupoPrincipal < ActiveRecord::Base
	belongs_to :miembro
	belongs_to :grupo_principal
end
