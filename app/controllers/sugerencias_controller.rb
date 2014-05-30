#encoding: utf-8
class SugerenciasController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter { |c| c.tiene_permiso "none"}
  layout 'base'

	def new
    @titulo = 'Buzón de Sugerencias'
    @igle = Iglesia.first
    @sugerencia = Sugerencia.new
  end

  def create
    @titulo = 'Buzón de Sugerencias'
    @sugerencia = Sugerencia.new(params[:sugerencia])
    @sugerencia.request = request
    if @sugerencia.deliver
      flash.now[:error] = nil
      flash.now[:notice] = 'Gracias por tu sugerencia!'
    else
      flash.now[:error] = 'No se pudo enviar tu sugerencia.'
      render :new
    end
  end
end
