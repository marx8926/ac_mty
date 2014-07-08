# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  count = 0 
  root = exports ? this
  root.SourceTServicio = "/recuperar_personas_inicio"
  root.DatosEnviar = null
  root.count = 0
  root.SelectToDrop = null
  root.TipoForm = null
  root.actionPersonas = null
  root.isedit = true

  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regniveles_org").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regniveles_org").hide()



  $("#form_nivelOrga").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "topRight", scroll: false}

  Actions = new DTActions
    'conf' : '0001',
    'idtable': 'miembrotable',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
    	$("#miembro_hidden").val aData.int_persona_id
	    $("#miembro").val aData.nombrecompleto

    'DropFunction': (nRow, aData, iDisplayIndex) ->
      root.SelectToDrop = aData.int_persona_id
      DisplayBlockUISingle "dangermodal"


  MiembroRowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  FormatoMiembroTable = [   { "sWidth": "35%","mDataProp": "int_persona_id"},
                            { "sWidth": "10%","mDataProp": "nombrecompleto"}
                           
                            ]

  MiembroTable = createDataTable "miembrotable", root.SourceTServicio, FormatoMiembroTable, null, MiembroRowCB

  ResponsableActions = new DTActions
    'conf' : '0001',
    'idtable': 'responsabletable',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
    	$("#responsable_hidden").val aData.int_persona_id
	    $("#responsable").val aData.nombrecompleto


  ResponsableRowCB = (  nRow, aData, iDisplayIndex ) ->
    ResponsableActions.RowCBFunction nRow, aData, iDisplayIndex

  ResponsableTable = createDataTable "responsabletable", root.SourceTServicio, FormatoMiembroTable, null, ResponsableRowCB


  PrepararDatos = ->
    root.DatosEnviar =
      "formulario" : $("#form_nivelOrga").serializeObject()

  SuccessFunction = ( data ) ->
    MessageSucces()
    $("#form_nivelOrga").reset()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000


  $("#btncrear").click (event) ->
    event.preventDefault()
    if $('#form_nivelOrga').validationEngine 'validate'
      DisplayBlockUI "loader"
      PrepararDatos()
      enviar "/informacion_general/guardar_nivel_organizacion", root.DatosEnviar, SuccessFunction, null

  $("#btneliminar").click (event) ->
    event.preventDefault()