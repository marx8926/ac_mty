#encoding: utf-8
require "date"

class ConfiguracionController < ApplicationController

	before_filter :authenticate_user!

	before_filter { |c| c.tiene_permiso "configuracion"}

	layout 'base'

	def datos_generales
		@titulo = 'Datos Generales - Configuración'		
	end 

  def recuperar_datos_generales
    data = {}
    iglesia = Iglesia.first
    pastor = NivelCrecimiento.find_by(:int_nivelcrecimiento_escala => -1, :int_nivelcrecimiento_estadoactual => 1).persona
    distrito = iglesia.ubigeo
    provincia = Ubigeo.find(distrito.int_ubigeo_dependencia)
    departamento = Ubigeo.find(provincia.int_ubigeo_dependencia)
    data[:dat_iglesia_feccreacion] = iglesia[:dat_iglesia_feccreacion].strftime("%d/%m/%Y")
    data[:dat_iglesia_fecregistro] = iglesia[:dat_iglesia_fecregistro].strftime("%d/%m/%Y")  
    data[:iglesia] = iglesia
    data[:pastor] = pastor
    data[:distrito] = distrito.int_ubigeo_id
    data[:provincia] = provincia.int_ubigeo_id
    data[:departamento] = departamento.int_ubigeo_id
    render :json => data , :status => :ok
  end

  def guardar_datos_generales
    ActiveRecord::Base.transaction do
      begin
        if params[:pastoractual] != params[:nuevopastor] && params[:nuevopastor] != ""
          NivelCrecimiento.find_by(:int_nivelcrecimiento_escala => -1,:int_nivelcrecimiento_estadoactual => 1).update(:int_nivelcrecimiento_estadoactual => 0)
          NivelCrecimiento.find_by(:int_nivelcrecimiento_escala => 1,:persona_id => params[:pastoractual]).update(:int_nivelcrecimiento_estadoactual => 1)
          NivelCrecimiento.find_by(:persona_id => params[:nuevopastor],:int_nivelcrecimiento_estadoactual => 1).update(:int_nivelcrecimiento_estadoactual => 0)
          npnivel = NivelCrecimiento.find_by(:persona_id => params[:nuevopastor],:int_nivelcrecimiento_escala => -1)
          if npnivel != nil
            npnivel.update(:int_nivelcrecimiento_estadoactual => 1)
          else
            NivelCrecimiento.create(
              :int_nivelcrecimiento_escala => -1,
              :int_nivelcrecimiento_estadoactual => 1,
              :persona_id => params[:nuevopastor])
          end
        end
        Iglesia.first.update(
          :dat_iglesia_feccreacion => params[:fec_creacion],
          :var_iglesia_telefono => params[:telefono],
          :var_iglesia_siglas => params[:sigla],
          :var_iglesia_nombre => params[:nombre],
          :var_iglesia_direccion => params[:direccion],
          :var_iglesia_referencia => params[:referencia],
          :dou_iglesia_longitud => params[:longitud],
          :dou_iglesia_latitud => params[:latitud],
          :ubigeo => Ubigeo.find(params[:distrito]))
      rescue
        raise ActiveRecord::Rollback
        render :json => { :resp => "error" }, :status => :ok
      end
    end
    render :json => { :resp => params[:nuevopastor] }, :status => :ok
  end
	
	def servicios
		@titulo = 'Servicios - Configuración'
	end

	def lugar
		@titulo = 'Lugar - Configuración'		
	end

	def categoria
		@titulo = 'Categoría - Configuración'		
	end

	def usuario
		@titulo = 'Usuario - Configuración'		
	end

	# 1: persona
	# 2: diezmo
	# 3: ofrenda
	# 4: asistencia
	# 5: informacion
	# 6: configuracion
	# 7: reporte

	def guardar_usuario
		ActiveRecord::Base.transaction do
			begin
				user = User.create!(
					:email => params[:email],
					:password => params[:password] ,
					:var_usuario_nombre => params[:nombre],
					:var_usuario_apellido => params[:apellido],
					:var_usuario_documento => params[:num_doc]
				)
				if params[:permiso].is_a? String
          UsuarioMenu.create!(
              :user => user,
              :menu => Menu.find_by(var_menu_nombre: params[:permiso])
              )
        else
          params[:permiso].each do |x|
            UsuarioMenu.create!(
              :user => user,
              :menu => Menu.find_by(var_menu_nombre: x)
              )
          end         
        end		
			rescue
				raise ActiveRecord::Rollback
			end
		end
		render :json => {:resp => params }, :status => :ok
	end

	def recuperar_usuario
		usuarios = User.all
		render :json => {:aaData => usuarios} , :status => :ok
	end

  def recuperar_menu_usuario
    usuarios_menus = UsuarioMenu.where("user_id" => params[:id])
    menus = []
    usuarios_menus.each{ |x|
    	menu = Menu.find(x[:menu_id])
    	menus.push(menu)
    }
    render :json => menus , :status => :ok
  end

  def editar_usuario
  	ActiveRecord::Base.transaction do
			begin        
        UsuarioMenu.destroy_all("user_id" => params[:id_usuario])
		  	user = User.lock.find(params[:id_usuario])
        if(params[:password] != "")
  		  	user.update!(
  		  				:email => params[:email],
  							:password => params[:password] ,
  							:var_usuario_nombre => params[:nombre],
  							:var_usuario_apellido => params[:apellido],
  							:var_usuario_documento => params[:num_doc])
        else
          user.update!(
                :email => params[:email],
                :var_usuario_nombre => params[:nombre],
                :var_usuario_apellido => params[:apellido],
                :var_usuario_documento => params[:num_doc])
        end

        if params[:permiso].is_a? String
        	UsuarioMenu.create!(
	  					:user => user,
	  					:menu => Menu.find_by(var_menu_nombre: params[:permiso])
	  					)
	      else
	      	params[:permiso].each do |x|
	  				UsuarioMenu.create!(
	  					:user => user,
	  					:menu => Menu.find_by(var_menu_nombre: x)
	  					)
	        end	      	
	      end

		  rescue
				raise ActiveRecord::Rollback
			end
		end
		render :json => {:resp => 'ok' }, :status => :ok
  	end

	def guardar_lugar

		form = params[:formulario]
		ActiveRecord::Base.transaction do
			begin
				lugar = Lugar.new({
					:var_lugar_descripcion => form[:descripcion] ,
					:var_lugar_estado => '1'
					})
				lugar.save!
			rescue
				raise ActiveRecord::Rollback
			end
		end
		render :json => {:resp => "ok" }, :status => :ok

	end

	def recuperar_lugar
		lugar = Lugar.all
		lugares =[]
		lugar.each{ |x|
			l={}
			l["int_lugar_id"] = x[:int_lugar_id]
			l["var_lugar_descripcion"] = x[:var_lugar_descripcion]
			l["var_lugar_estado"] = x[:var_lugar_estado]
			l["acciones"] = ""
			lugares.push l
		}
		render :json => {:aaData => lugares} , :status => :ok

	end

	def drop_lugar
		lugar = Lugar.lock.find(params[:idlugar])
		Lugar.destroy_all(int_lugar_id: params[:idlugar])
		lugar.destroy
		render :json => { :datos => params[:idlugar]}, :status => :ok
	end

	def editar_lugar
		form = params[:formulario]
		lugar = Lugar.lock.find(form[:idlugar])
		lugar.update!(:var_lugar_descripcion => form[:descripcion])
		render :json => {:resp => "ok" }, :status => :ok
	end

	def guardar_servicio
		ActiveRecord::Base.transaction do
			begin
				servicio = Servicio.new({:var_servicio_nombre => params[:nombre], :int_servicio_tipo => params[:tipo]})	
				servicio.save!
				turno = Turno.new({:var_turno_horainicio => params[:hinicio],
					:var_turno_horafin => params[:hfin],
				 	:int_turno_dia => params[:dia], :servicio => servicio})
				turno.save!
			rescue
	        render :json => nil , :status => :internal_server_error
					raise ActiveRecord::Rollback
			end
		end    	
    	render :json => {:resp => "ok" }, :status => :ok			
	end

	def recuperar_servicio
		servicio = Servicio.all
		arrayserv = []
		servicio.each do |x|
			serv = {}
			serv['int_servicio_id'] = x.int_servicio_id
			serv['var_servicio_nombre'] = x.var_servicio_nombre
			serv['int_servicio_tipo'] = x.int_servicio_tipo
			if x.int_servicio_tipo == 1
				serv['int_servicio_tipo_desc'] = "Culto General"
			else
				serv['int_servicio_tipo_desc'] = "Culto Jovenes"
			end
			tshow= ""
			turno = Turno.find_by("servicio_id" => x.int_servicio_id)
			case turno[:int_turno_dia]
			when 0
				dia = "Domingo"
			when 1
				dia = "Lunes"
			when 2
				dia = "Martes"
			when 3
				dia = "Miercoles"
			when 4
				dia = "Jueves"
			when 5
				dia = "Viernes"
			else
				dia = "Sabado"
  		end

  			tshow = tshow + "<p>"+dia+" : "+turno[:var_turno_horainicio]+" - "+ turno[:var_turno_horafin]+" </p>"
			serv['turno_data'] = turno
			serv['turnoshow'] = tshow
			arrayserv.push serv
		end
    render :json => { :aaData => arrayserv }, :status => :ok
	end

	def drop_servicio
		servicio = Servicio.lock.find(params[:idservicio])
		Turno.destroy_all(servicio_id: params[:idservicio])
		servicio.destroy
		render :json => { :datos => params[:idservicio]}, :status => :ok
	end

	def editar_servicio
		ActiveRecord::Base.transaction do
			begin  
        Turno.destroy_all(servicio_id: params[:idservicio])
				servicio = Servicio.lock.find(params[:idservicio])
				servicio.update(:var_servicio_nombre => params[:nombre], :int_servicio_tipo => params[:tipo])	
				turno = Turno.new({:var_turno_horainicio => params[:hinicio],
					:var_turno_horafin => params[:hfin],
				 	:int_turno_dia => params[:dia], :servicio => servicio})
				turno.save!	
			rescue
				raise ActiveRecord::Rollback
			end
		end
		render :json => { :datos => params}, :status => :ok
	end

	def guardar_categoria
		ActiveRecord::Base.connection.execute("SELECT sp_inst_registrar_constante ('"+ params[:descripcion]+"',2)")
		render :json => {:resp => "ok" }, :status => :ok
	end

	def gettabla_categorias
		categoriaarray = Constante.where("int_constante_clase = 2 and int_constante_valor > 0")
		categorias =[]
		categoriaarray.each{ |c|
			categoria = {}			
			categoria[:int_constante_id] = c[:int_constante_id]
			categoria[:var_constante_descripcion] = c[:var_constante_descripcion]
			categoria[:int_constante_valor] = c[:int_constante_valor]
			categoria[:acciones] = ""
			categorias.push categoria
		}
		render :json => {:aaData => categorias} , :status => :ok
	end

	def editar_categoria
		constante = Constante.lock.find(params[:idcategoria])
		constante.update!(:var_constante_descripcion => params[:descripcion])
		render :json => {:resp => "ok" }, :status => :ok
	end

	def TipoNiveles
		@titulo = 'Tipo Niveles de Organización - Configuración'
	end
   
  def TipoGrupos
		@titulo = 'Tipo de Grupos - Configuración'
	end

end
