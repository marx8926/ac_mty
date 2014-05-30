class ServiciosgeneralesController < ApplicationController

  before_filter :authenticate_user!

	def personas_autocomplete
		persona = Persona.all
		todo = []
		persona.each{ |p|

			item = { }
			
			item['label'] = p.var_persona_nombres+" "+p.var_persona_apellidos
			item['int_persona_id'] = p.int_persona_id
			todo.push item
		}
		render :json => todo , :status => :ok
	end

	def getcategorias
		categorias = Constante.where("int_constante_clase = 2 and int_constante_valor > 0")
		render :json => categorias , :status => :ok
	end

  def get_dia_servicio
    turno = Turno.find_by("servicio_id" => params[:idservicio])
    render :json => turno[:int_turno_dia], :status => :ok
  end
end