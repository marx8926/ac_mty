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
    $("#regasistencia").show()

  Actions = new DTActions
    'conf' : '0001',
    'idtable': 'table_responsables',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
      $("#responsable_hidden").val aData.int_persona_id
      $("#responsable").val aData.nombrecompleto

      
    'DropFunction': (nRow, aData, iDisplayIndex) ->
      root.SelectToDrop = aData.int_persona_id
      DisplayBlockUISingle "dangermodal"


  MiembroRowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  FormatoMiembroTable = [   { "sWidth": "35%","mDataProp": "int_persona_id"},
                            { "sWidth": "10%","mDataProp": "nombrecompleto"}
                           
                            ]

  ResponsablesTable = createDataTable "table_responsables", root.SourceTServicio, FormatoMiembroTable, null, MiembroRowCB

  PrepararDatos = ->
    root.DatosEnviar =
      "formulario" : $("#form_grupoprincipal").serializeObject()

  SuccessFunction = ( data ) ->
    MessageSucces()
    $("#form_grupoprincipal").reset()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000


  $("#btncrear").click (event) ->
    event.preventDefault()
    if $('#form_grupoprincipal').validationEngine 'validate'
      DisplayBlockUI "loader"
      PrepararDatos()
      enviar "/informacion_general/guardar_grupos_principales", root.DatosEnviar, SuccessFunction, null

  $("#btneliminar").click (event) ->
    event.preventDefault()
