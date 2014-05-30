# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.SourceTServicio = "/recuperar_diezmos_inicio"
root.DatosEnviar = null

jQuery ->  
  personas = getAjaxObject "/persona_servicio_complete"

  SuccessFunction = ( data ) ->
    DiezmoTable.fnReloadAjax root.SourceTServicio    
    $("form").reset()
    MessageSucces()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  FormatoPersonaTable = [   { "sWidth": "40%","mDataProp": "persona"},
                            { "sWidth": "15%","mDataProp": "fecha"},
                            { "sWidth": "15%","mDataProp": "monto"},
                            { "sWidth": "30%","mDataProp": "peticion"}
                            ]

  DiezmoTable = createDataTable "table_diezmos", root.SourceTServicio, FormatoPersonaTable, null, null

  $('#registrar_diezmo').click (event) ->
    event.preventDefault()
    $("#diezmo_div").show()

  $("#persona").autocomplete
    source: personas
    delay: 1
    open: (event, ui) ->
      $("#persona_hidden").val ""
    select: (event, ui) ->
      event.preventDefault()
      $("#persona_hidden").val ui.item.int_persona_id
      $("#persona").val ui.item.label
      
  $(".btnCancelar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#diezmo_div").hide()

  $("#btnGuardar_Diezmo").click (event) ->
    event.preventDefault()
    if $("#form_diezmo").validationEngine 'validate'
      if $("#persona_hidden").val() != ""
        DisplayBlockUI "loader"
        #Llamada a envio Post
        console.log $("#form_diezmo").serializeObject()
        #enviar "/diezmos_guardar", $("#form_diezmo").serialize(), SuccessFunction, null
      else
        alert "El miembro seleccionado no esta registrado"

  $("#form_diezmo").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "centerRight", scroll: false}