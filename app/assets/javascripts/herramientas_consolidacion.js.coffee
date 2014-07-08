# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.count = 0
root.SourceTAsistencia = "/recuperar_asistencia"


jQuery ->
  count = 0



  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regasistencia").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regasistencia").hide()
    CategoriaTable.fnClearTable

  $("input[name=\"temas\"]").on "click", ->
    if $(this).is(":checked")
      $("#showModal").modal "show"
    else
      console.log "nocheckeds"
    return

  TemasTable = $('#clases').dataTable
    "aoColumns": [{"mDataProp": "id"},{"mDataProp": "nombre"},{"mDataProp": "btn_elim"}]
    "bPaginate": false
    "sDom": "<r>t<'row-fluid'>"
    "fnCreatedRow": (  nRow, aData, iDisplayIndex ) ->
      $(nRow).find('a').tooltip('hide');
      $(nRow).find('.delete-row').click (e) ->
        index = $(TemasTable.fnGetData()).getIndexObj aData, 'id'
        TemasTable.fnDeleteRow index

  $("#add").click (event) ->
    event.preventDefault()
    tem = 
          "id": root.count
          "nombre" : $("#Nombre").val()
          "btn_elim":getActionButtons "001"
    root.count++
    TemasTable.fnAddData tem

  $("#canceltemas").click (event) ->
    event.preventDefault()
    TemasTable.fnClearTable() 


  PrepararDatos = ->
    root.DatosEnviar =
      "formulario" : $("#form_herramienta").serializeObject()
      "tabla" : TemasTable.fnGetData()

  HideForms = ->
    $("#regasistencia").hide()
    $("#form_herramienta").reset()
    TemasTable.fnClearTable()    
    

  SuccessFunction = ( data ) ->

    HideForms()
    MessageSucces()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  $("#btnGuardar_Herramienta").click (event) ->
    event.preventDefault()
    if $('#form_herramienta').validationEngine 'validate'
      DisplayBlockUI "loader"
      PrepararDatos()
      enviar "/consolidacion/guardar_herramienta", root.DatosEnviar, SuccessFunction, null

  root.actions = getActionButtons "111"


  Actions = new DTActions
    'conf' : '0110',
    'idtable': 'tabla_herramientas',
    'ViewFunction': (nRow, aData, iDisplayIndex) ->
      root.isedit = false
    'EditFunction': (nRow, aData, iDisplayIndex) ->
      root.isedit = false
    'DropFunction': (nRow, aData, iDisplayIndex) ->
      DisplayBlockUISingle "dangermodal"

  RowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  FormatoTable = [   { "sWidth": "35%","mDataProp": "id"},
                            { "sWidth": "10%","mDataProp": "descripcion"},
                            { "sWidth": "10%","mDataProp": "duracion"},
                            { "sWidth": "10%","mDataProp": "repeticion"},
                            { "sWidth": "10%", "mDataProp": "asignado"},
                            { "sWidth": "15%", "mDataProp": "estado"}
                            ]

  PersonaTable = createDataTable "tabla_herramientas", "servicios_herramientas_tabla", FormatoTable, null, RowCB
