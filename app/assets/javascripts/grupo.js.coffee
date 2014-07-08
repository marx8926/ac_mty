# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.SourceTServicio = "/recuperar_personas_inicio"
root.DatosEnviar = null
root.count = 0
root.SelectToDrop = null
root.TipoForm = null
root.actionPersonas = null
root.isedit = false

jQuery(document).ready -> 

  Actions = new DTActions
    'conf' : '0001',
    'idtable': 'table_responsables',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
      $("#responsable_hidden").val aData.int_persona_id
      $("#responsable").val aData.nombrecompleto
      
    'DropFunction': (nRow, aData, iDisplayIndex) ->
      root.SelectToDrop = aData.int_persona_id
      DisplayBlockUISingle "dangermodal"

  ActionsP = new DTActions
    'conf' : '0001',
    'idtable': 'miembros_table',
    'SelectFunction': (nRow, aData, iDisplayIndex) ->
      $("#persona_hidden").val aData.int_persona_id
      $("#persona").val aData.nombrecompleto

      eliminar = getActionButtons "001"
      nom=
        "int_persona_id": aData.int_persona_id
        "nombrecompleto" : aData.nombrecompleto
        "btn_elim": eliminar 

      MiembrosTable.fnAddData nom
      
    'DropFunction': (nRow, aData, iDisplayIndex) ->
      root.SelectToDrop = aData.int_persona_id
      DisplayBlockUISingle "dangermodal"

  ActionsG = new DTActions
    'conf' : '1100',
    'idtable': 'tabla_grupos',
    'ViewFunction': (nRow, aData, iDisplayIndex) ->
      root.isedit = false   
      $("#isedit").val "0"

    'EditFunction': (nRow, aData, iDisplayIndex) ->      
      root.isedit = true
      $("#isedit").val "1"
      $("#nombre").val aData.nombre
      $("#idgroup").val aData.id
      $("#grupo_principal").val aData.grupo_principal_id
      $("#responsable_hidden").val aData.int_grupopequenio_responsable
      $("#responsable").val aData.grupo_pequenio
      $("#tipo_grupo").val aData.tipo
      $("#lugar").val aData.lugar
      $("#fecha_grupo").val aData.inicio
      $("#direccion").val aData.direccion
      $("#select_dia").val aData.dia
      $("#select_reunion").val aData.frecuencia
      $("#hora").val aData.hora
      $("#grupo").show()

      persona = getAjaxObject "/informacion_general/lista_personas_grupo/"+aData.id
      $(persona).each (index) ->
        eliminar = getActionButtons "001"
        nom= 
          "int_persona_id": this.persona_id
          "nombrecompleto" : this.nombre
          "btn_elim": eliminar 

        MiembrosTable.fnAddData nom





  MiembroRowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  MiembroPRowCB = (  nRow, aData, iDisplayIndex ) ->
    ActionsP.RowCBFunction nRow, aData, iDisplayIndex

  MiembroGRowCB = (  nRow, aData, iDisplayIndex ) ->
    ActionsG.RowCBFunction nRow, aData, iDisplayIndex


  FormatoMiembroTable = [   { "sWidth": "35%","mDataProp": "int_persona_id"},
                            { "sWidth": "10%","mDataProp": "nombrecompleto"}
                           
                            ]

  FormatoMiembroGTable = [  { "sWidth": "5%","mDataProp": "id"},
                            { "sWidth": "20%","mDataProp": "nombre"},
                            { "sWidth": "20%", "mDataProp": "grupo_principal"},
                            { "sWidth": "20%", "mDataProp": "grupo_pequenio"},
                            { "sWidth": "20%", "mDataProp": "inicio"}                           
                            ]

  ResponsablesTable = createDataTable "table_responsables", root.SourceTServicio, FormatoMiembroTable, null, MiembroRowCB
  PersonaTable = createDataTable "miembros_table", root.SourceTServicio, FormatoMiembroTable, null, MiembroPRowCB
  GrupoTable = createDataTable "tabla_grupos", "/informacion_general/servicio_grupos", FormatoMiembroGTable, null, MiembroGRowCB


  MiembrosTable = $('#tabla_seleccionada').dataTable
    "aoColumns": [{"sWidth": "15%" , "mDataProp": "int_persona_id"},{ "sWidth": "50%", "mDataProp": "nombrecompleto"},
    { "sWidth": "35%", "mDataProp": "btn_elim"}]
    "bPaginate": false
    "sDom": "<r>t<'row-fluid'>"
    "fnCreatedRow": (  nRow, aData, iDisplayIndex ) ->
      $(nRow).find('a').tooltip('hide');
      $(nRow).find('.delete-row').click (e) ->
        index = $(MiembrosTable.fnGetData()).getIndexObj aData, 'id'
        MiembrosTable.fnDeleteRow index



  $("#form_grupos").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}  

  $("#Grupowizard").bwizard
    nextBtnText: "Siguiente &rarr;"
    backBtnText: "&larr; Anterior"   
   
  PrepararDatosMiembro = ->
    root.DatosEnviar =
      "formulario" : $("#form_grupos").serializeObject()
      "tabla" : MiembrosTable.fnGetData()

  HideForms = ->   
    $("#grupo").hide()    
    $("#form_grupos").reset()
    aux = root.isedit
    root.isedit = false
    $("#Grupowizard").bwizard 'show', '0'
    root.isedit = aux
    $("#form_grupos").enable()
    MiembrosTable.fnClearTable()

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 100

  $('#registrar_grupo').click (event) ->
    root.isedit = true 
    event.preventDefault()
    HideForms()
    $("#grupo").show()

  $('#guardar').click (event) ->
    event.preventDefault
    DisplayBlockUI "loader"
    PrepararDatosMiembro()
    if($("#isedit").val == "0")
      enviar "/informacion_general/guardar_grupos", root.DatosEnviar, MessageSucces, null
    else
      enviar "/informacion_general/editar_grupos", root.DatosEnviar, MessageSucces, null

    GrupoTable.fnReloadAjax "/informacion_general/servicio_grupos"
    HideForms()
 

  $(".btncancelarform").click (event) ->
    event.preventDefault()
    HideForms()

  $("#reload").click (event) ->
    event.preventDefault()
    PersonaTable.fnReloadAjax root.SourceTServicio