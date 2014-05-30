root = exports ? this
root.SourceTServicio = "/configuracion/recuperar_servicio"
root.SelectToDrop = null
jQuery ->
  Actions = new DTActions
    'conf' : '011',
    'idtable': 'tablaservicios',
    'EditFunction': (nRow, aData, iDisplayIndex) ->
      $("#nombre").val aData.var_servicio_nombre
      $("#tipo").val aData.int_servicio_tipo
      $("#idservicio").val aData.int_servicio_id 
      $("#hinicio").val aData.turno_data.var_turno_horainicio
      $("#hfin").val aData.turno_data.var_turno_horafin
      $("#dia").val aData.turno_data.int_turno_dia
      $("#servicio").show()
      $("#nombre").focus()
      $("#btnGuardarServicio").show()
      $("#btnRegistrarServicio").hide()
      $("#registrar").text("Guardar Cambios")

    'DropFunction': (nRow, aData, iDisplayIndex) ->      
      root.SelectToDrop = aData.int_servicio_id
      DisplayBlockUISingle "dangermodal"

  FormatoServiciosTable = [   { "sWidth": "30%","mDataProp": "var_servicio_nombre"},
                              { "sWidth": "20%","mDataProp": "int_servicio_tipo_desc"},
                              { "sWidth": "30%","mDataProp": "turnoshow"}
                              ]

  ServiciosRowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex      

  ServiciosTable = createDataTable "tablaservicios", root.SourceTServicio, FormatoServiciosTable, null, ServiciosRowCB

  $("#btnSiEliminar").click (event) ->
    event.preventDefault()
    DisplayBlockUI "loader"
    enviar "/configuracion/drop_servicio", {"idservicio":root.SelectToDrop}, SuccessFunctionDropServicio, null

  $("#btnSiGuardar").click (event) ->
    event.preventDefault()
    if $("#formServicio").validationEngine 'validate'
      DisplayBlockUI "loader"
      enviar "/configuracion/editar_servicio", $("#formServicio").serializeObject(), SuccessFunctionServicio, null

  $(".btnNo").click (event) ->
    event.preventDefault()
    $.unblockUI()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("#formServicio").reset()
    $("#servicio").hide()
    $("#btnGuardarServicio").hide()
    $("#btnRegistrarServicio").show()
    $("#registrar").text("Agregar Servicio")


  $('#registrar').click (event) ->
    event.preventDefault()
    $("#servicio").show()

# Proceso para enviar metodo Post

# 1. Preparar Datos

  # Datos para enviar en formato JSON
  ###PrepararDatos= ->
    root.DatosEnviar =
      "formulario" : $("#formServicio").serializeObject()###

  # Funcion de respuesta CORRECTA
  # Los datos de respuesta se reciben en data
  SuccessFunctionServicio = ( data ) ->
    MessageSucces()
    #recargar datos de tabla Servicios
    ServiciosTable.fnReloadAjax root.SourceTServicio
    #resetear formulario
    $("#formServicio").reset()
    #mostrar datos de respuesta
    $("#btnGuardarServicio").hide()
    $("#btnRegistrarServicio").show()
    $("#registrar").text("Agregar Servicio")
    $("#servicio").hide()

  $("#btnGuardarServicio").click (event) ->
    event.preventDefault()
    DisplayBlockUISingle "confirmmodal"

# 2. Enviar Datos
  $("#btnRegistrarServicio").click (event) ->
    event.preventDefault()
    #Llamada a envio Post
    if $("#formServicio").validationEngine 'validate'
      DisplayBlockUI "loader"
      enviar "/configuracion/guardar_servicio", $("#formServicio").serializeObject(), SuccessFunctionServicio, null

# Fin Proceso enviar Formulario

  #Refrescar tabla al elimnar servicio
  SuccessFunctionDropServicio = (data) ->
    MessageSucces()
    ServiciosTable.fnReloadAjax root.SourceTServicio
    MessageSucces()
  
  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  $("#formServicio").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}
