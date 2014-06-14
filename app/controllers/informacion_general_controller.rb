#encoding: utf-8
class InformacionGeneralController < ApplicationController
	before_filter :authenticate_user!

	before_filter { |c| c.tiene_permiso "configuracion"}

	layout 'base'

	def datos_generales
		@titulo = 'Datos Generales - Información General'		
	end

  def niveles_organizacion
    @titulo = 'Niveles de la Organización - Información General'    
  end

  def guardar_nivel_organizacion

    form = params[:formulario]
    miembro = form[:miembro_hidden]
    responsable = form[:responsable_hidden]
    nivel = form[:tipo_nivel]

    ActiveRecord::Base.transaction do
      begin
        persona = Miembro.find_by(:persona_id=>miembro)
        nivelid = NivelLiderazgo.create({:int_niveliderazgo_tiponivel => nivel,
            :int_niveliderazgo_responsable => responsable,
             :miembro => persona })
        nivelid.save!

        rescue
          raise ActiveRecord::Rollback
        end
    end
    render :json => {:resp => "ok" } , :status => :ok

  end

  def grupos
    @titulo = 'Grupos - Información General'    
  end

  def guardar_grupos

    form = params[:formulario]
    tabla = params[:tabla]

    ActiveRecord::Base.transaction do
      begin
        gp = GrupoPequenio.create({:var_grupopequenio_nombre => form[:nombre],
          :int_grupopequenio_tipo => form[:tipo_grupo],
          :lugar => Lugar.find(form[:lugar]) ,
          :grupo_principal => GrupoPrincipal.find(form[:grupo_principal]),
          :dat_grupopequenio_fechaInicio => form[:fecha_grupo],
          :int_grupopequenio_diaReunion => form[:select_dia],
          :var_grupopequenio_hora => form[:hora],
          :var_grupopequenio_direccion => form[:direccion] ,
          :int_grupopequenio_frecuenciareunion => form[:select_reunion] ,
          :int_grupopequenio_responsable => form[:responsable_hidden] 
          })
        gp.save!

        if tabla != nil
          tabla.each do |y|
            x = y.last
            lm = ListaMiembroGp.create({:grupo_pequenio=> gp,
            :persona => Persona.find(x[:int_persona_id]), :dat_listamiembrogp_fechaRegistro => form[:fecha_grupo],
            :var_listamiembrogp_estado => "1"})
            lm.save!
          end
        end

        
        rescue
          raise ActiveRecord::Rollback
        end
    end
    render :json => {:resp => "ok" } , :status => :ok

  end

  def ministerios_area
    @titulo = 'Ministerios/ Áreas de Servicios - Información General'    
  end

  def plan_trabajo
    @titulo = 'Plan de Trabajo - Información General'    
  end

  def inform_plantrabajo
    @titulo = 'Datos Generales - Información General'   
  end

  def inform_ministerio_area
    @titulo = 'Niveles de la Organización - Información General'    
  end
  
  def inform_rept_grupos
    @titulo = 'Ministerios/ Áreas de Servicios - Información General'    
  end

  def grupos_principales
    @titulo = 'Grupos Principales - Información General'   
  end

  def guardar_grupos_principales

    form = params[:formulario]
    responsable = form[:responsable_hidden]
    codigo = form[:codigo]
    fecha = form[:fec_creacion]
    tipo = form[:tipo_grupo]

    ActiveRecord::Base.transaction do
      begin
        gr = GrupoPrincipal.create({:var_grupoprincipal_codigo => codigo,
          :int_grupoprincipal_tipo => tipo, :int_grupoprincipal_responsable => responsable,
          :dat_grupoprincipal_fechaCreacion => fecha,
          :int_grupoprincipal_nromiembros => 0})
        gr.save!

        rescue
          raise ActiveRecord::Rollback
        end
    end
    render :json => {:resp => "ok" } , :status => :ok
  end
end
