
root = exports ? this

jQuery ->
  root.DatosEnviar = null
  root.SelectToDrop = null

  FormatoLugarTable = [   { "sWidth": "20%","mDataProp": "int_lugar_id"},
                              { "sWidth": "60%","mDataProp": "var_lugar_descripcion"},
                              { "sWidth": "20%","mDataProp": "acciones"}
                              ]

  LugarRowCB = (  nRow, aData, iDisplayIndex ) ->
    index = $(TablaLugar.fnGetData()).getIndexObj aData, 'int_lugar_id'
    acciones = getActionButtons "011"
    TablaLugar.fnUpdate( acciones, index, 2 );
    $(nRow).find('.delete-row').click (event) ->
      event.preventDefault()
      root.SelectToDrop = aData.int_lugar_id
      DisplayBlockUISingle "dangermodal"
    $(nRow).find('.edit_row').click (event) ->
      event.preventDefault()
      $("#descripcion").val aData.var_lugar_descripcion
      $("#idlugar").val aData.int_lugar_id
      $("#btnRegistrar_Lugar").hide()
      $("#btnGuardar_Lugar").show()

  TablaLugar = createDataTable "lugartable", "/configuracion/recuperar_lugar", FormatoLugarTable, null, LugarRowCB


	 # guardar lugar

	 # Proceso para enviar metodo Post

	 # 1. Preparar Datos

	 # Datos para enviar en formato JSON
  PrepararDatosL = ->
    root.DatosEnviar = 
      "formulario" : $("#form_lugar").serializeObject()

  $("#btnSiEliminar").click (event) ->
    event.preventDefault()
    DisplayBlockUI "loader"
    enviar "/configuracion/drop_lugar", {"idlugar":root.SelectToDrop}, SuccessFunctionL, null

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  SuccessFunctionL = ( data ) ->
    MessageSucces()
    TablaLugar.fnReloadAjax "/configuracion/recuperar_lugar"
    $("#form_lugar").reset()
    console.log data

  $(".btnNo").click (event) ->
    event.preventDefault()
    $.unblockUI()

  $(".btnCancelar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#btnRegistrar_Lugar").show()
    $("#btnGuardar_Lugar").hide()

  $("#btnGuardar_Lugar").click (event) ->
    event.preventDefault()
    if $('#form_lugar').validationEngine 'validate'
      DisplayBlockUI "loader"
      #Llamada a preparar Datps
      PrepararDatosL()
      #Llamada a envio Post
      enviar "/configuracion/editar_lugar", root.DatosEnviar, SuccessFunctionL, null

	 # 2. Enviar Datos
  $("#btnRegistrar_Lugar").click (event) ->
    event.preventDefault()
    if $('#form_lugar').validationEngine 'validate'
      DisplayBlockUI "loader"
      #Llamada a preparar Datps
      PrepararDatosL()
   	  #Llamada a envio Post
      enviar "/configuracion/guardar_lugar", root.DatosEnviar, SuccessFunctionL, null
   

  $("#form_lugar").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}
