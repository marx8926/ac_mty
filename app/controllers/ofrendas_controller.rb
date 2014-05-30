require "date"
require "json"

class OfrendasController < ApplicationController

	before_filter :authenticate_user!
	before_filter {|c| c.tiene_permiso "ofrenda"}

    layout 'base'

	def index
		@titulo = 'Ofrendas'
	end

	def guardar

		ActiveRecord::Base.transaction do
			begin

				fecha = params[:fecha]

				monto = params[:monto]
				#servicio = params[:servicio]
				turno = params[:turno]


				@ofrenda = Ofrenda.new
				@ofrenda.dec_ofrenda_monto = monto
				@ofrenda.dec_ofrenda_fecharegistro = fecha


				@turn = Turno.find(turno)

				@ofrenda.turno = @turn
				@ofrenda.save!

			rescue
				raise ActiveRecord::Rollback
				render :json => { :resp => "bad"} , :status => :ok
			end
		end

		render :json => { :resp => "ok" } , :status => :ok

	end

	def recuperar_init

		todo = []

		ofrendas = Ofrenda.last(300)

		if ofrendas.length > 0
			ofrendas.each{ |x|
				temp = {}
				
				turn = x.turno
				servicio = nil
				turno = nil
				

				if turn.nil? == false

					turno = turn[:var_turno_horainicio]
					servicio = turn.servicio.var_servicio_nombre

				end
				temp['turno'] = turno
				temp['servicio'] = servicio
				temp["monto"] = x[:dec_ofrenda_monto]
				temp["registro"] = x[:dec_ofrenda_fecharegistro].strftime("%d/%m/%Y")
				temp["int_ofrenda_id"] = x[:int_ofrenda_id]
				temp["acciones"]= ""
				todo.push temp
			}

		end

		render :json => { "aaData" => todo }, :status => :ok
	end



	def recuperar_ofrenda_filtro

		todo = []

		ofrendas = Ofrenda.where(dec_ofrenda_fecharegistro: (params[:inicio] .. params[:fin]) )

		if ofrendas.length > 0
			ofrendas.each{ |x|
				temp = {}
				
				turn = x.turno
				servicio = nil
				turno = nil
				

				if turn.nil? == false

					turno = turn[:var_turno_horainicio]
					servicio = turn.servicio.var_servicio_nombre

				end
				temp['turno'] = turno
				temp['servicio'] = servicio
				temp["monto"] = x[:dec_ofrenda_monto]
				temp["registro"] = x[:dec_ofrenda_fecharegistro].strftime("%d/%m/%Y")

				todo.push temp
			}

		end

		render :json => { "aaData" => todo }, :status => :ok
	end
	def recuperar_turno
		todo = []

		id = params[:id]
		
		result = Turno.where("servicio_id" => id )
		result.each {|p|
			t = {}
			t['inicio'] =  p.var_turno_horainicio
			t['turno'] = p.int_turno_id
			todo.push t
		}

		render :json => todo, :status => :ok
	end

end
