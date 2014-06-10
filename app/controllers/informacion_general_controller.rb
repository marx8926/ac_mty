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
