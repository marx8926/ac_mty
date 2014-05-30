class ListaMiembroGp < ActiveRecord::Base
	belongs_to :grupo_pequenios
	belongs_to :persona
end
