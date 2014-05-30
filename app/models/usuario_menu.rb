class UsuarioMenu < ActiveRecord::Base

	belongs_to :user
	belongs_to :menu
	
end
