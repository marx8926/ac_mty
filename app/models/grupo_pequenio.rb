class GrupoPequenio < ActiveRecord::Base
	has_many :lista_miembro_gp
	belongs_to :lugar
end
