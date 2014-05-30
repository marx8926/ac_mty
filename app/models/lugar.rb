class Lugar < ActiveRecord::Base
	has_many :personas
	has_many :grupo_pequenios
	
end
