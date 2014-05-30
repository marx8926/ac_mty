# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.SourceOfrendas = "/recuperar_ofrendas_init"

jQuery ->

  SuccessFunction = ( data ) ->
    OfrendaTable.fnReloadAjax root.SourceOfrendas    
    $("form").reset()
    MessageSucces()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  FormatoOfrenda = [  { "sWidth": "25%","mDataProp": "servicio"},
                      { "sWidth": "35%","mDataProp": "turno"},
                      { "sWidth": "25%","mDataProp": "registro"},
                      { "sWidth": "15%","mDataProp": "monto"}
                      ]

  OfrendaRowCB = (  nRow, aData, iDisplayIndex ) ->
    index = $(OfrendaTable.fnGetData()).getIndexObj aData, 'int_ofrenda_id'
    #acciones = getActionButtons "011"
    #OfrendaTable.fnUpdate( acciones, index, 4 ); 



  OfrendaTable = createDataTable "dataOfremdas", root.SourceOfrendas, FormatoOfrenda, null, OfrendaRowCB

  $(".btnCancelar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#ofrenda_div").hide()

  $('#registrar_ofrenda').click (event) ->
    event.preventDefault()
    $("#ofrenda_div").toggle()
    $("form").reset()

  # Proceso para enviar metodo Post

  # 1. Preparar Datos

    # Datos para enviar en formato JSON
  PrepararDatos = ->
    root.DatosEnviar = $("#form_ofrenda").serialize()
  # Proceso para enviar metodo Post

  # 2. Enviar Datos
  $("#btnGuardar_Ofrenda").click (event) ->
    event.preventDefault()
    if $('form').validationEngine 'validate'
      DisplayBlockUI "loader"
      PrepararDatos()
      enviar "/ofrendas_guardar",  root.DatosEnviar , SuccessFunction, null

  cargar_turno = ->
    turnos = getAjaxObject "/recuperar_turno_inicio/"+$("#_servicio").val()
    cargarSelect turnos, "turno", "turno", "inicio"

  $("#_servicio").change ->
    cargar_turno()
    
  cargar_turno()
  $("form").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "centerLeft", scroll: false}
  
