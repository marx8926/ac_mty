class GrupoPequenio < ActiveRecord::Base
	has_many :lista_miembro_gps
	belongs_to :lugar
	belongs_to :grupo_principal
end
