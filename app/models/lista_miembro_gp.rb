class ListaMiembroGp < ActiveRecord::Base
	belongs_to :grupo_pequenio
	belongs_to :persona
end
