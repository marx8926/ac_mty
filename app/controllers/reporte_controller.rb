class ReporteController < ApplicationController
    
  before_filter :authenticate_user!
  before_filter { |c| c.tiene_permiso "reporte"}

  layout 'base'

	def diezmo
    @titulo = 'Diezmo - Reportes'
  end

  def gettabladiezmo
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]
    if params[:idpersona] != "0"
      persona = "' and id_persona="+params[:idpersona]
    else
      persona = "'"
    end
    reporte = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_diezmo where fecharegistro BETWEEN '"+@fecha1+"' and '"+@fecha2+persona)
    render :json => { 'aaData' => reporte }, :status => :ok
  end

  def diezmosexcel
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]
    if params[:idpersona] != "0"
      persona = "' and id_persona="+params[:idpersona]
    else
      persona = "'"
    end
    diezmos = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_diezmo where fecharegistro BETWEEN '"+@fecha1+"' and '"+@fecha2+persona)
    total = 0

    diezmos.each do |o|
      total = total + o["monto"].to_f
    end
    @total = total
    @diezmos = diezmos
  end

  def ofrenda
    @titulo = 'Ofrenda - Reportes'
  end

  def gettablaofrenda
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]
    reporte = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_ofrendas where fecha BETWEEN '"+@fecha1+"' and '"+@fecha2+"' and id="+params[:idservicio])
    render :json => { 'aaData' => reporte }, :status => :ok
  end

  def ofrendaesexcel
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]
    ofrendas = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_ofrendas where fecha BETWEEN '"+@fecha1+"' and '"+@fecha2+"' and id="+params[:idservicio])
    total = 0
    ofrendas.each do |o|
      total = total + o["monto"].to_f
    end
    @total = total
    @ofrendas = ofrendas
  end

  def membresia
    @titulo = 'Miembros y Visitantes - Reportes'
  end

  def gettablamiembro
    reporte = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_miembros where fecregistro BETWEEN '"+params[:inicio]+"' and '"+params[:fin]+"'")
    render :json => { 'aaData' => reporte }, :status => :ok
  end

  def miembrosexcel
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]
    @personas = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_miembros where fecregistro BETWEEN '"+params[:inicio]+"' and '"+params[:fin]+"'")
  end

  def gettablavisitante
    reporte = ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_visitantes where fecregistro BETWEEN '"+params[:inicio]+"' and '"+params[:fin]+"'")
    render :json => { 'aaData' => reporte }, :status => :ok
  end

  def visitantesexcel
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]
    @personas =ActiveRecord::Base.connection.execute("SELECT * FROM view_get_rpt_visitantes where fecregistro BETWEEN '"+params[:inicio]+"' and '"+params[:fin]+"'")
  end

  def asistencia
    @titulo = 'Asistencia - Reportes'
  end

  def gettablaasistencia
    reporte = ActiveRecord::Base.connection.execute("SELECT * FROM sp_get_rpt_asistencia_serviciocategoriames('"+params[:inicio]+"','"+params[:fin]+"')")
    render :json => { 'aaData' => reporte }, :status => :ok
  end

  def gettablaasistenciageneral
    reporte = ActiveRecord::Base.connection.execute("SELECT * FROM sp_get_rpt_asistencia_general ('"+params[:inicio]+"','"+params[:fin]+"')")
    render :json => { 'aaData' => reporte }, :status => :ok
  end

  def asistenciaexcel
    @fecha1 = params[:inicio]
    @fecha2 = params[:fin]

    @asistencia_general = ActiveRecord::Base.connection.execute("SELECT * FROM sp_get_rpt_asistencia_general ('"+params[:inicio]+"','"+params[:fin]+"')")

    @asistencia = ActiveRecord::Base.connection.execute("SELECT * FROM sp_get_rpt_asistencia_serviciocategoriames('"+params[:inicio]+"','"+params[:fin]+"')")
    total = 0
    @asistencia_general.each do |o|
      total = total + o["cantidad"].to_f
    end
    @total = total
  end

  def servicios
      @titulo = 'Servicios - Reportes'
  end
end
