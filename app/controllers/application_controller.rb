class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end

  def tiene_permiso(nombremenu)

    @mactive = 'm'+nombremenu
    @menuvariable = {}
    # 1: persona
    # 2: diezmo
    # 3: ofrenda
    # 4: asistencia
    # 5: informacion
    # 6: configuracion
    # 7: reporte
    @menuvariable["persona"] = false
    @menuvariable["diezmo"] = false
    @menuvariable["ofrenda"] = false
    @menuvariable["asistencia"] = false
    @menuvariable["informacion"] = false
    @menuvariable["configuracion"] = false
    @menuvariable["reporte"] = false
  	usuarios_menus = UsuarioMenu.where("user_id" => current_user[:id])
    @nombreusuario = current_user[:var_usuario_nombre]+" "+current_user[:var_usuario_apellido]
  	permiso = false
	  usuarios_menus.each do |x|
      menu = Menu.find(x[:menu_id])
      if (nombremenu != "none")
      	if(menu[:var_menu_nombre] == nombremenu)
      		permiso = true
      	end
      else
        permiso = true
      end
      menudesc = menu[:var_menu_nombre].to_s
      @menuvariable[menudesc] = true
    end
    if !permiso
    	redirect_to index_path
    end
	end
    
end
