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
end
