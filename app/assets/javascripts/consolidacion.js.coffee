# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


root = exports ? this
root.count = 0
root.SourceTAsistencia = "/recuperar_asistencia"
root.DatosEnviar = null



jQuery ->
  count = 0
  Actions = new DTActions
    'conf' : '0001',
    'idtable': 'ganadostable',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
      root.isedit = false
      $("#showModal").modal('show')
      $("#nuevo").val aData.id


  
  PrepararDatosMiembro = ->
    root.DatosEnviar =
      "formulario" : $("#form_grupo").serializeObject()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  SuccessFunction = ( data ) ->
    GrupoTable.fnReloadAjax "servicios_grupos_principales"
    MessageSucces()

  ActionsG = new DTActions
    'conf' : '0001',
    'idtable': 'grupo_table',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
      root.isedit = false
      $("#red").val aData.id
      DisplayBlockUI "loader"
      #Llamada a preparar Datps
      
      PrepararDatosMiembro()
      enviar "/consolidacion/guardar_nuevos_grupos", root.DatosEnviar, SuccessFunction, null
      

  RowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  RowGCB = (  nRow, aData, iDisplayIndex ) ->
    ActionsG.RowCBFunction nRow, aData, iDisplayIndex

  FormatoTable = [   { "sWidth": "10%","mDataProp": "id"},
                            { "sWidth": "20%","mDataProp": "nombres"},
                            { "sWidth": "25%","mDataProp": "direccion"},
                            { "sWidth": "15%","mDataProp": "telefono"},
                            { "sWidth": "10%", "mDataProp": "convertido"}
                            ]

  FormatTable = [   { "sWidth": "10%","mDataProp": "id"},
                    { "sWidth": "20%","mDataProp": "codigo"},
                            { "sWidth": "50%","mDataProp": "nombres"},                  
                            { "sWidth": "20%", "mDataProp": "num_miembros"}
                            ]

 

  $("#btnGenerar_ganados").click (event) ->
  	event.preventDefault()
  	
  	ini = $("#inicio").val()
  	ini = ini.replace('/','-')
  	ini = ini.replace('/','-')

  	url = "servicios_nuevos_ganados/".concat(ini)
  	url = url.concat("/")
  	fin = $("#fin").val()
  	fin = fin.replace('/','-')
  	fin = fin.replace('/','-')

  	url = url.concat(fin)
  	NuevosTable = createDataTable "ganadostable", url , FormatoTable, null, RowCB

  GrupoTable = createDataTable "grupo_table", "servicios_grupos_principales", FormatTable, null, RowGCB

