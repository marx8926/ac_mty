#encoding: utf-8
class DiezmosController < ApplicationController

	before_filter :authenticate_user!
	before_filter { |c| c.tiene_permiso "diezmo"}

	layout 'base'

	def index
		@titulo = 'Diezmos'
	end

	def guardar
		ActiveRecord::Base.transaction do
  		begin
  			persona = Persona.find(params[:persona_hidden])
  			diezmo = Diezmo.create({
  				:dec_diezmo_monto => params[:monto],
  				:var_diezmo_peticion => params[:peticion] ,
  				:dat_diezmo_fecharegistro => params[:fecha],
  				:persona => persona
  			})
  		rescue Exception => e
  			raise ActiveRecord::Rollback
  			render :json => {:resp => e } , :status => :ok
  		end
		end
		render :json => {:resp => "ok" } , :status => :ok
	end


	def recuperar_inicio
		diezmo = ActiveRecord::Base.connection.execute("SELECT * from view_get_tbl_diezmo")
		render :json => { 'aaData' => diezmo }, :status => :ok
	end	
end
