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

	def guardar_herramienta

		form = params[:formulario]
		tabla = params[:tabla]
		todo = nil

		ActiveRecord::Base.transaction do

			begin


				nombre = form[:nombre_herramienta]
				clases = form[:numero_clases]
				repeticion = form[:numero_repeticion]
				

				if nombre.length > 0 

					he = HerramientaConsolidacion.create!({ :var_herramconsolidacion_descripcion => nombre ,
						:int_herramconsolidacion_nrodias => clases , :int_herramconsolidacion_repeticion =>repeticion,
						:var_herramconsolidacion_estado => '1' })
				

					if tabla != nil
						tabla.each{ |y|
							x = y.last
							temas = ListaTema.create!({:var_tema_nombre => x[:nombre],
							:herramienta_consolidacion => he})
						}
					end

				end

			rescue
				raise ActiveRecord::Rollback

				render :json => {:resp => "bad" } , :status => :ok


			end

		end

		render :json => {:resp => "ok" } , :status => :ok
	end

	def servicios_herramientas_tabla

		todo = ActiveRecord::Base.connection.execute("select * from view_lista_herramientas")
		render :json => { :aaData => todo }, :status => :ok
		
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
