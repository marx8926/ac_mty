require "date"
require "json"

class GanarController < ApplicationController

	before_filter :authenticate_user!

	before_filter { |c| c.tiene_permiso "persona"}

	layout 'base'

	def index
		@titulo = 'Persona'
	end

	def guardar_miembro

		form = params[:formulario]
		tabla = params[:tabla]

		ActiveRecord::Base.transaction do
			begin
				persona = Persona.create({:dat_persona_fecregistro => form[:fec_conversion] , 
					:var_persona_nombres => form[:nombre] , :var_persona_apellidos => form[:apellido],
					:int_persona_edad => form[:edad] , :dat_persona_fecNacimiento => form[:fec_nac] ,
					:var_persona_profesion => form[:profesion] , :var_persona_ocupacion => form[:ocupacion],
					:var_persona_sexo => form[:sexo] , :var_persona_dni => form[:dni],
					:var_persona_estado => "1", :var_persona_email => form[:email] ,
					:dat_persona_bautismo => form[:fec_bautismo],
					:var_persona_invitado => form[:invitado] , :iglesia => Iglesia.first , :lugar => Lugar.find(form[:lugar]) })

				if form[:fec_bautismo].length > 0 
					
					miem = Miembro.create({:persona => persona, 
						:dat_miembro_fechaAsignacion => form[:fec_conversion],
						:var_miembro_estado => '1'})
				end

				ch = Chart.lock.find_by(:int_chart_anio => persona.dat_persona_fecregistro.year,
				 :int_chart_mes => persona.dat_persona_fecregistro.month)

				if ch.nil? == false
					ch.int_chart_miembro = ch.int_chart_miembro + 1
					ch.save!

				else

					anio = (1 .. 12 ).to_a

					mes = persona.dat_persona_fecregistro.month

					anio.each{ |i|

						metrica = Chart.create!( int_chart_anio: persona.dat_persona_fecregistro.year  , int_chart_mes: i )

						if i == mes
							metrica.int_chart_miembro = metrica.int_chart_miembro + 1
							metrica.save!
						end

					}
				end


				direccion = Direccion.new({ :var_direccion_descripcion => form[:direccion], 
					:var_direccion_referencia => form[:referencia],
					:dou_direccion_longitud => nil, :dou_direccion_latitud => nil , 
					:var_direccion_estado => "1", :ubigeo => Ubigeo.find(form[:distrito]),
					:persona => persona
					})

				nivel = NivelCrecimiento.new({ :int_nivelcrecimiento_escala => 1 ,
					:int_nivelcrecimiento_estadoactual => 1,
					:persona => persona})

				peticion = Peticion.new({ :var_peticion_motivooracion => form[:mot_oracion],
					:persona => persona , :dat_peticion_fecha => form[:fec_conversion]
					})				

				direccion.save!
				nivel.save!
				peticion.save!
				
				if tabla != nil
					tabla.each do |y|
						x = y.last
						telefono = Telefono.new({:int_telefono_tipo => x[:tipo_val],
						:var_telefono_codigo => x[:codigo],
						:var_telefono_numero => x[:tel], :persona => persona})
						telefono.save!
					end
				end

			rescue
				raise ActiveRecord::Rollback
			end

		end

		render :json => {:resp => "ok" } , :status => :ok

	end

	def editar_miembro

		form = params[:formulario]
		tabla = params[:tabla]
		todo = nil

		ActiveRecord::Base.transaction do

			begin


				idPersona = form[:idpersona]
				

				if idPersona!= nil and idPersona.length > 0

					p= Persona.lock.find(idPersona)
					p.update(
            :dat_persona_fecregistro => form[:fec_conversion],
            :var_persona_nombres => form[:nombre],
            :var_persona_apellidos => form[:apellido],
            :int_persona_edad => form[:edad],
            :dat_persona_fecNacimiento => form[:fec_nac],
            :var_persona_profesion => form[:profesion],
            :var_persona_ocupacion => form[:ocupacion],
            :var_persona_sexo => form[:sexo],
            :var_persona_dni => form[:dni],
            :var_persona_estado => "1",
            :var_persona_email => form[:email],
            :dat_persona_bautismo => form[:fec_bautismo],
            :var_persona_invitado => form[:invitado],
            :lugar_id => form[:lugar])

					m = Miembro.lock.find_by(:persona_id => idPersona)
					if m != nil 
						m.update(
						:dat_miembro_fechaAsignacion => form[:fec_conversion])
					else
						miem = Miembro.create({:persona => p, 
						:dat_miembro_fechaAsignacion => form[:fec_conversion],
						:var_miembro_estado => '1'})
					end

					

        Peticion.find_by(:persona_id => idPersona).update(:var_peticion_motivooracion => form[:mot_oracion])

					direccion =  Direccion.lock.find_by("persona_id" => idPersona)

					direccion.var_direccion_descripcion = form[:direccion]
					direccion.var_direccion_referencia = form[:referencia]
					direccion.var_direccion_estado = "1"
					direccion.ubigeo = Ubigeo.find(form[:distrito])
					
					direccion.save!

					if tabla != nil
						tabla.each{ |y|
							x = y.last
							telefono = Telefono.lock.find_by({:int_telefono_tipo => x[:tipo_val],
							:var_telefono_codigo => x[:codigo],
							:var_telefono_numero => x[:tel], :persona_id => idPersona})

							if telefono != nil
								telefono.update!({:int_telefono_tipo => x[:tipo_val],
								:var_telefono_codigo => x[:codigo],
								:var_telefono_numero => x[:tel], :persona_id => idPersona})
							else
								Telefono.create!({:int_telefono_tipo => x[:tipo_val],
								:var_telefono_codigo => x[:codigo],
								:var_telefono_numero => x[:tel], :persona_id => idPersona})
							end

						}

					else
						Telefono.destroy!(:persona_id => idPersona)
					end

				end

			rescue
				raise ActiveRecord::Rollback

				render :json => {:resp => "bad" } , :status => :ok


			end

		end

		render :json => {:resp => "ok" } , :status => :ok


	end

	def eliminar_persona
		id = params[:id]
		ActiveRecord::Base.transaction do
			begin
				persona = Persona.find(id)
				persona.update!(:var_persona_estado => 0)
      end
    end
		render :json => {:resp => "ok" } , :status => :ok

	end

	def guardar_visita

		form = params[:formulario]
		tabla = params[:tabla]

		ActiveRecord::Base.transaction do
			begin

				persona = Persona.new({:dat_persona_fecregistro =>  DateTime.now(), :var_persona_nombres => form[:nombrev] , 
					:var_persona_apellidos => form[:apellidov],
					:int_persona_edad => form[:edadv] , :dat_persona_fecNacimiento => nil ,
					:var_persona_profesion => nil , :var_persona_ocupacion => nil,
					:var_persona_sexo => nil , :var_persona_dni => nil,
					:var_persona_estado => "1", :var_persona_email => nil ,
					:var_persona_invitado => form[:invitadov] , :iglesia => Iglesia.first , 
					:lugar => nil
					  })

				persona.save!

				ch = Chart.lock.find_by(:int_chart_anio => persona.dat_persona_fecregistro.year,
				 :int_chart_mes => persona.dat_persona_fecregistro.month)

				if ch.nil? == false
					ch.int_chart_visita = ch.int_chart_visita + 1
					ch.save!

				else

					anio = (1 .. 12 ).to_a

					mes = persona.dat_persona_fecregistro.month

					anio.each{ |i|

						metrica = Chart.create!( int_chart_anio: persona.dat_persona_fecregistro.year  , int_chart_mes: i )

						if i == mes
							metrica.int_chart_visita = metrica.int_chart_visita + 1
							metrica.save!
						end

					}
				end

				peticion = Peticion.new({ :var_peticion_motivooracion => form[:mot_oracionv],
					:persona => persona , :dat_peticion_fecha => DateTime.now()
					})

				nivel = NivelCrecimiento.new({ :int_nivelcrecimiento_escala => 0 , :int_nivelcrecimiento_estadoactual => 1,
					:persona => persona})

				direccion = Direccion.new({ :var_direccion_descripcion => nil, 
					:var_direccion_referencia => nil,
					:dou_direccion_longitud => nil, :dou_direccion_latitud => nil , 
					:var_direccion_estado => "1", :ubigeo => Ubigeo.find(1354),
					:persona => persona
					})
				
				direccion.save!
				peticion.save!				
				nivel.save!

				if tabla != nil
					tabla.each{ |y|
						x = y.last
						telefono = Telefono.new({:int_telefono_tipo => x[:tipo_val],
						:var_telefono_codigo => x[:codigo],
						:var_telefono_numero => x[:tel], :persona => persona})

						telefono.save!
					}
				end

				
			rescue
				raise ActiveRecord::Rollback
			end
		end

		render :json => {:resp => "ok" } , :status => :ok

	end

	def editar_visita

		form = params[:formulario]
		tabla = params[:tabla]
		todo = nil

		ActiveRecord::Base.transaction do
			begin
        idPersona = form[:idPersonav]
        Telefono.destroy_all(:persona_id => idPersona)

        p= Persona.lock.find(idPersona).update(
          :var_persona_nombres => form[:nombrev],
				  :var_persona_apellidos => form[:apellidov],
				  :int_persona_edad => form[:edadv],
				  :var_persona_invitado => form[:invitadov])

        if form[:nivelc].to_i != 0
          NivelCrecimiento.find_by(:int_nivelcrecimiento_estadoactual => 1,:persona_id => idPersona).update(:int_nivelcrecimiento_estadoactual => 0)
          NivelCrecimiento.create(:int_nivelcrecimiento_escala => 1 , :int_nivelcrecimiento_estadoactual => 1,:persona => p)
        end

        Peticion.lockfind_by(:persona_id => idPersona).update(:var_peticion_motivooracion => form[:mot_oracionv])

				tabla.each do |y|
          x = y.last
					Telefono.create!(:int_telefono_tipo => x[:tipo_val],
					:var_telefono_codigo => x[:codigo],
					:var_telefono_numero => x[:tel], :persona_id => idPersona)
				end
			rescue
				raise ActiveRecord::Rollback
				render :json => {:resp => "bad" } , :status => :ok
			end
		end
		render :json => {:resp => "ok" } , :status => :ok
	end

	def recuperar_personas_inicio

		persona = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_personas")		
		render :json => { 'aaData' => persona }, :status => :ok
	end

	def recuperar_persona_id
		persona = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_persona_completo where int_persona_id="+params[:id])[0]	
		telefono = Telefono.joins(:persona).where("persona_id" => params[:id])
		persona[:telefonos] = telefono
		render :json => persona, :status => :ok

	end

	def recuperar_personas_filtro
		persona = Persona.where(dat_persona_fecregistro: (params[:inicio] .. params[:fin]) )
		todo = []
		if persona.length > 0
			t = {}
			persona.each{ |x|
        		t = {}
				t['nombrecompleto'] = x[:var_persona_nombres]+" "+x[:var_persona_apellidos]
				t['registro'] = x[:created_at].strftime("%d/%m/%Y")
				t['persona_data'] = x

				if x[:dat_persona_fecNacimiento].nil? == false
					t['fecnacimiento'] = x[:dat_persona_fecNacimiento].strftime("%d/%m/%Y")
				else
					t['fecnacimiento'] = nil
				end

				if x[:dat_persona_fecregistro].nil? == false
					t['convertido'] = x[:dat_persona_fecregistro].strftime("%d/%m/%Y")
				else
					t['convertido'] = nil
				end

				telefono = Telefono.joins(:persona).where("persona_id" => x[:int_persona_id])
				nivel = NivelCrecimiento.joins(:persona).where({"persona_id" => x[:int_persona_id], "int_nivelcrecimiento_estadoactual" => 1 })

				tel = ""

				if telefono.length > 0
					telefono.each{ |i|


						temp = ( i[:var_telefono_codigo].nil? ? "" : i[:var_telefono_codigo] )+" "+ ( i[:var_telefono].nil? ? "" : i[:var_telefono] )
						tel = tel + "<p>" + temp + "</p>"
					}
				end
				
				level = nil

				nivel.each{ |i|

					case i[:int_nivelcrecimiento_escala]
					when 0
						level = "Visitante"
					when 1
						level = "Miembro"
					when 2
						level = "Pastor Principal"
					else
						level = "Administrador"
					end
				}

				#direccion
				dir = Direccion.joins(:persona).find_by("persona_id" => x[:int_persona_id])
				t['direccion'] = dir

				distrito = nil
				provincia = nil
				departamento = nil

				if dir.nil? == false
				  distrito = dir.ubigeo.int_ubigeo_id
				  prov = Ubigeo.where(int_ubigeo_id: dir.ubigeo.int_ubigeo_dependencia).take

				  provincia = prov[:int_ubigeo_id]

                  dep = Ubigeo.find(prov.int_ubigeo_dependencia)
                  departamento = dep[:int_ubigeo_id]

				end
				t['distrito'] = distrito
				t['provincia'] = provincia
				t['departamento'] = departamento

				t['var_persona_acciones']= ""
				t['telefono'] = tel
				t['telefono_data'] = telefono

				t['nivel'] = level

				todo.push(t)
			}
		end
		render :json => { 'aaData' => todo }, :status => :ok
	end

	def personacsv
		@personas = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_personas")
		respond_to do |format|
			format.xls
    	end
	end
end
