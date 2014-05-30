#encoding: utf-8
class EscuelaBiblicaController < ApplicationController
  before_filter :authenticate_user!

	before_filter { |c| c.tiene_permiso "configuracion"}

	layout 'base'

	def maestros
		@titulo = 'Maestros - Escuela Biblica'		
	end

  	def ambientes
    	@titulo = 'Ambientes - Escuela Biblica'	   
  	end

  	def cursos
		@titulo = 'Cursos - Escuela Biblica'		
	end

  	def programar_cursos
    	@titulo = 'Programar Cursos - Escuela Biblica'	   
  	end

  	def gestion_inscripcion
		@titulo = 'Gestión de Inscripción - Escuela Biblica'		
	end

  	def gestion_asistencia
    	@titulo = 'Gestión de Asistencia  - Escuela Biblica'	   
  	end

  	def gestion_notas
		@titulo = 'Gestión de Notas - Escuela Biblica'		
	end

end
