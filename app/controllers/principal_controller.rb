class PrincipalController < ApplicationController
	before_filter :authenticate_user!
	before_filter { |c| c.tiene_permiso "none"}
	layout 'base'

	def index
		@titulo = 'Inicio'
	end
	def donar
		@titulo = 'Donar'
	end
	def ayuda
		@titulo = 'Ayuda'
	end
end