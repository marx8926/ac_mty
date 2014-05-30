
root = exports ? this

jQuery ->
  root.DatosEnviar = null
  root.SelectToDrop = null

  FormatoLugarTable = [       { "sWidth": "60%","mDataProp": "var_constante_descripcion"},
                              { "sWidth": "20%","mDataProp": "acciones"}
                              ]

  LugarRowCB = (  nRow, aData, iDisplayIndex ) ->
    index = $(TablaCategoria.fnGetData()).getIndexObj aData, 'int_constante_id'
    acciones = getActionButtons "010"
    TablaCategoria.fnUpdate acciones, index, 1
    $(nRow).find('.edit_row').click (event) ->
      event.preventDefault()
      $("#descripcion").val aData.var_constante_descripcion
      $("#idcategoria").val aData.int_constante_id
      $("#btnRegistrar_Categoria").hide()
      $("#btnGuardar_Categoria").show()

  TablaCategoria = createDataTable "categoriatable", "/configuracion/gettabla_categorias", FormatoLugarTable, null, LugarRowCB

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
    TablaCategoria.fnReloadAjax "/configuracion/gettabla_categorias"
    $("#form_categoria").reset()
    console.log data

  $(".btnNo").click (event) ->
    event.preventDefault()
    $.unblockUI()

  $(".btnCancelar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#btnRegistrar_Categoria").show()
    $("#btnGuardar_Categoria").hide()

  $("#btnGuardar_Categoria").click (event) ->
    event.preventDefault()
    if $('#form_categoria').validationEngine 'validate'
      DisplayBlockUI "loader"
      enviar "/configuracion/editar_categoria", $("#form_categoria").serializeObject(), SuccessFunctionL, null

	 # 2. Enviar Datos
  $("#btnRegistrar_Categoria").click (event) ->
    event.preventDefault()
    if $('#form_categoria').validationEngine 'validate'
      DisplayBlockUI "loader"
      enviar "/configuracion/guardar_categoria", $("#form_categoria").serializeObject(), SuccessFunctionL, null
   

  $("#form_categoria").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}
