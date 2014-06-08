Lean::Application.routes.draw do
  get "escuela_biblica/index"
  #devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  devise_for :users, :controllers => { :registrations => "registrations" }

  get "index" => "principal#index"
  get "donaciones" => "principal#donar"
  get "ayuda" => "principal#ayuda"

  get "persona" => "ganar#index"
  post "persona_guardar" => "ganar#guardar_miembro"
  post "visita_guardar" => "ganar#guardar_visita"
  post "persona_editar_miembro" => "ganar#editar_miembro"
  post "persona_editar_visita" => "ganar#editar_visita"
  post "persona_eliminar_persona" => "ganar#eliminar_persona"
  get "personacsv" => "ganar#personacsv"

  get "recuperar_persona_id/(:id)" => "ganar#recuperar_persona_id"
  get "recuperar_personas_inicio" => "ganar#recuperar_personas_inicio"
  get "recuperar_personas_filtrado/(:inicio)/(:fin)" => "ganar#recuperar_personas_filtro" , as: :recuperar_personas_filtro
  
  get "diezmos" => "diezmos#index"
  post "diezmos_guardar" => "diezmos#guardar"
  get "recuperar_diezmos_inicio" => "diezmos#recuperar_inicio"
  get "recuperar_diezmos_filtrado/(:inicio)/(:fin)" => "diezmos#recuperar_diezmo_filtro"

  get "ofrendas" => "ofrendas#index"
  post "ofrendas_guardar" => "ofrendas#guardar"
  get "recuperar_turno_inicio/(:id)" => "ofrendas#recuperar_turno", as: :recuperar_turnos
  get "recuperar_ofrendas_init" => "ofrendas#recuperar_init"
  get "recuperar_ofrendas_filtrado/(:inicio)/(:fin)" => "ofrendas#recuperar_ofrenda_filtro", as: :recuperar_ofrendas_filtro

  get "configuracion/servicios" => "configuracion#servicios"
  post "configuracion/guardar_servicio" => "configuracion#guardar_servicio"
  get "configuracion/recuperar_servicio" => "configuracion#recuperar_servicio"
  post "configuracion/editar_servicio" => "configuracion#editar_servicio"
  post "configuracion/drop_servicio" => "configuracion#drop_servicio"
  get "configuracion/get_dia_servicio/(:idservicio)" => "configuracion#get_dia_servicio"
  
  get "configuracion/usuario" => "configuracion#usuario"
  get "configuracion/recuperar_usuario" => "configuracion#recuperar_usuario"
  post "configuracion/guardar_usuario" => "configuracion#guardar_usuario"
  get "configuracion/recuperar_menu_usuario/(:id)" => "configuracion#recuperar_menu_usuario"
  post "configuracion/editar_usuario" => "configuracion#editar_usuario"

  get "configuracion/lugar" => "configuracion#lugar"
  get "configuracion/recuperar_lugar" => "configuracion#recuperar_lugar"
  post "configuracion/guardar_lugar" => "configuracion#guardar_lugar"
  post "configuracion/drop_lugar" => "configuracion#drop_lugar"
  post "configuracion/editar_lugar" => "configuracion#editar_lugar"

  get "configuracion/categoria" => "configuracion#categoria"
  post "configuracion/guardar_categoria" => "configuracion#guardar_categoria"
  get "configuracion/gettabla_categorias" => "configuracion#gettabla_categorias"
  post "configuracion/editar_categoria" => "configuracion#editar_categoria"

  get "configuracion/datos_generales" => "configuracion#datos_generales"
  get "configuracion/recuperar_datos_generales" => "configuracion#recuperar_datos_generales"
  post "configuracion/guardar_datos_generales" => "configuracion#guardar_datos_generales"
  get "persona_servicio_complete" => "serviciosgenerales#personas_autocomplete"
  get "getcategorias" => "serviciosgenerales#getcategorias"
  get "get_dia_servicio/(:idservicio)" => "serviciosgenerales#get_dia_servicio"

  get "configuracion/TipoNiveles" => "configuracion#TipoNiveles"
  get "configuracion/TipoGrupos" => "configuracion#TipoGrupos"

  get "asistencia" => "asistencia#index"
  post "asistencia_guardar" => "asistencia#guardar"
  get "recuperar_asistencia" => "asistencia#recuperar_asistencia"

  get "dashboard" => "informacion#index"
  get "data_miembro" => "informacion#chart_miembro"
  get "data_visitante" => "informacion#chart_visitante"
  get "data_pie" => "informacion#pie_chart_init"

  get "dashboard_diezmo" => "informacion#diezmo"
  post "recuperar_data_diezmo" => "informacion#recuperar_data_diezmo"
  get "dashboard_ofrenda" => "informacion#ofrenda"
  post "recuperar_data_ofrenda" => "informacion#recuperar_data_ofrenda"
  get "dashboard_membresia" => "informacion#membresia"
  get "dashboard_asistencia" => "informacion#asistencia"
  post "recuperar_data_asistencia" => "informacion#recuperar_data_asistencia"

  get "reporte_diezmo" => "reporte#diezmo"
  get "gettabladiezmo/(:inicio)/(:fin)/(:idpersona)" => "reporte#gettabladiezmo"
  get "diezmosexcel/(:inicio)/(:fin)/(:idpersona)/(:nombre)" => "reporte#diezmosexcel"
  get "reporte_ofrenda" => "reporte#ofrenda"
  get "gettablaofrenda/(:inicio)/(:fin)/(:idservicio)" => "reporte#gettablaofrenda"
  get "ofrendaesexcel/(:inicio)/(:fin)/(:idservicio)/(:nombre)" => "reporte#ofrendaesexcel"
  get "reporte_membresia" => "reporte#membresia"
  get "reporte_asistencia" => "reporte#asistencia"
  get "gettablaasistencia/(:inicio)/(:fin)" => "reporte#gettablaasistencia"
  get "gettablaasistenciageneral/(:inicio)/(:fin)" => "reporte#gettablaasistenciageneral"
  get "asistenciaexcel/(:inicio)/(:fin)/(:nombre)" => "reporte#asistenciaexcel"
  get "reporte_servicios" => "reporte#servicios"
  get "gettablamiembro/(:inicio)/(:fin)" => "reporte#gettablamiembro"
  get "miembrosexcel/(:inicio)/(:fin)/(:nombre)" => "reporte#miembrosexcel"
  get "gettablavisitante/(:inicio)/(:fin)" => "reporte#gettablavisitante"
  get "visitantesexcel/(:inicio)/(:fin)/(:nombre)" => "reporte#visitantesexcel"
  #get "reporte_servicios" => "reporte#servicios"

  get "informacion_general/datos_generales" => "informacion_general#datos_generales"
  get "informacion_general/niveles_organizacion" => "informacion_general#niveles_organizacion"
  post "informacion_general/guardar_nivel_organizacion" => "informacion_general#guardar_nivel_organizacion"
  get "informacion_general/grupos" => "informacion_general#grupos"
  get "informacion_general/ministerios_area" => "informacion_general#ministerios_area"
  get "informacion_general/plan_trabajo" => "informacion_general#plan_trabajo"
  get "informacion_general/inform_plantrabajo" => "informacion_general#inform_plantrabajo"
  get "informacion_general/inform_ministerio_area" => "informacion_general#inform_ministerio_area"
  get "informacion_general/inform_rept_grupos" => "informacion_general#inform_rept_grupos"
  get "informacion_general/grupos_principales" => "informacion_general#grupos_principales"
  get "informacion_general/gettablaresponsables_red" => "serviciosgenerales#responsables_red"

  get "escuela_biblica/maestros" => "escuela_biblica#maestros"
  get "escuela_biblica/ambientes" => "escuela_biblica#ambientes"
  get "escuela_biblica/cursos" => "escuela_biblica#cursos"
  get "escuela_biblica/programar_cursos" => "escuela_biblica#programar_cursos"
  get "escuela_biblica/gestion_inscripcion" => "escuela_biblica#gestion_inscripcion"
  get "escuela_biblica/gestion_asistencia" => "escuela_biblica#gestion_asistencia"
  get "escuela_biblica/gestion_notas" => "escuela_biblica#gestion_notas"


  get "consolidacion/lista_nuevos_ganados" => "consolidacion#lista_nuevos_ganados"
  get "consolidacion/coordinadores" => "consolidacion#coordinadores"
  get "consolidacion/consolidadores" => "consolidacion#consolidadores"
  get "consolidacion/herramientas_consolidacion" => "consolidacion#herramientas_consolidacion"
  get "consolidacion/asignar_miembros_consolidacion" => "consolidacion#asignar_miembros_consolidacion"
  get "consolidacion/seguimiento_consolidado" => "consolidacion#seguimiento_consolidado"

  get "consolidacion/informe_lista_nuevos_ganados" => "consolidacion#informe_lista_nuevos_ganados"
  get "consolidacion/informe_coordinadores" => "consolidacion#informe_coordinadores"
  get "consolidacion/informe_herramientas_consolidacion" => "consolidacion#informe_herramientas_consolidacion"
  get "consolidacion/informe_miembros_consolidar" => "consolidacion#informe_miembros_consolidar"
  get "consolidacion/informe_seguimiento_consolidado" => "consolidacion#informe_seguimiento_consolidado"

  resources "sugerencias", only: [:new, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'principal#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  #root "home#index"
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end