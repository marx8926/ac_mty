class GrupoPequenio < ActiveRecord::Base
	set_primary_key :var_grupopequenio_id
	has_many :lista_miembro_gp
	belongs_to :lugar
end
