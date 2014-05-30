require "date"
require "json"

class AsistenciaController < ApplicationController

	before_filter :authenticate_user!
	before_filter { |c| c.tiene_permiso "asistencia"}

	layout 'base'

	def index
		@titulo = 'Asistencia'
	end

	def guardar
		form = params[:formulario]
		tabla = params[:tabla]
		ActiveRecord::Base.transaction do
			begin
				servicio = Servicio.find(form[:servicio])
				tabla.each do |y|
					x = y.last
					asist = Asistencia.create(
						:dat_asistencia_fecregistro => DateTime.now(),
						:dat_asistencia_fecasistencia => form[:fecha],
						:int_asistencia_categoria => x[:categoriaid],
						:int_asistencia_cantidad => x[:asistente],
						:servicio => servicio
						)
				end
			rescue
				raise ActiveRecord::Rollback
			end
		end		
		render :json => {:data => tabla,:resp => "ok" } , :status => :ok
	end

	def recuperar_asistencia
		asistencia = ActiveRecord::Base.connection.execute("SELECT * from view_get_tbl_asistencia")
		render :json => { "aaData" => asistencia } , :status => :ok
	end

end