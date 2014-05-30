#encoding: utf-8
class ConsolidacionController < ApplicationController
	before_filter :authenticate_user!

	before_filter { |c| c.tiene_permiso "configuracion"}

	layout 'base'

	def lista_nuevos_ganados
	@titulo = 'Datos Generales - Configuración'
	end

	def coordinadores
	@titulo = 'Datos Generales - Configuración'
	end

	def consolidadores
	@titulo = 'Datos Generales - Configuración'
	end

	def herramientas_consolidacion
	@titulo = 'Datos Generales - Configuración'
	end

	def asignar_miembros_consolidacion
	@titulo = 'Datos Generales - Configuración'
	end

	def seguimiento_consolidado
	@titulo = 'Datos Generales - Configuración'
	end

	def informe_lista_nuevos_ganados
	@titulo = 'Datos Generales - Configuración'
	end

	def informe_coordinadores
	@titulo = 'Datos Generales - Configuración'
	end

	def informe_herramientas_consolidacion
	@titulo = 'Datos Generales - Configuración'
	end

	def informe_miembros_consolidar
	@titulo = 'Datos Generales - Configuración'
	end

	def informe_seguimiento_consolidado
	@titulo = 'Datos Generales - Configuración'
	end
end
