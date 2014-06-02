root = exports ? this


jQuery(document).ready ->  

  $("#form_iglesia").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "centerLeft", scroll: false}
  ubigeos = getAjaxObject "/ubi.json"
  personas = getAjaxObject("/persona_servicio_complete")
      

  LoadData = () ->
    datos = getAjaxObject "/configuracion/recuperar_datos_generales"
    $("#fec_creacion").val datos.dat_iglesia_feccreacion
    $("#telefono").val datos.iglesia.var_iglesia_telefono
    $("#nombre").val datos.iglesia.var_iglesia_nombre
    $("#sigla").val datos.iglesia.var_iglesia_siglas
    $("#pastoractual").val datos.pastor.int_persona_id
    $("#psn1").val datos.pastor.var_persona_nombres+" "+datos.pastor.var_persona_apellidos
    $("#pastoractual2").val datos.pastor2.int_persona_id
    $("#psn2").val datos.pastor2.var_persona_nombres+" "+datos.pastor2.var_persona_apellidos

    $("#direccion").val datos.iglesia.var_iglesia_direccion
    $("#referencia").val datos.iglesia.var_iglesia_referencia
    $("#latitud").val datos.iglesia.dou_iglesia_latitud
    $("#longitud").val datos.iglesia.dou_iglesia_longitud
    cargarUbigeo ubigeos, "distrito", "provincia", "departamento",datos.distrito,datos.provincia,datos.departamento

  SuccessFunctionI = ( data ) ->
    console.log data
    MessageSucces()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"
    ), 1000

  LoadData()

  $("#btnGuardar_iglesia").click (event) ->
    event.preventDefault()
    if $('form').validationEngine 'validate'
      DisplayBlockUI "loader"
      enviar "/configuracion/guardar_datos_generales", $("#form_iglesia").serializeObject(), SuccessFunctionI, null

  $("#psn1").autocomplete
    source: personas
    delay: 1
    open: (event, ui) ->
      $("#nuevopastor").val ""
    select: (event, ui) ->
      $("#nuevopastor").val ui.item.int_persona_id
      $("#psn1").val ui.item.label
      false

  $("#psn2").autocomplete
    source: personas
    delay: 1
    open: (event, ui) ->
      $("#nuevopastor2").val ""
    select: (event, ui) ->
      $("#nuevopastor2").val ui.item.int_persona_id
      $("#psn2").val ui.item.label
      false