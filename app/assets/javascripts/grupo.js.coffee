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
root.isedit = true

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



  MiembroRowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  MiembroPRowCB = (  nRow, aData, iDisplayIndex ) ->
    ActionsP.RowCBFunction nRow, aData, iDisplayIndex


  FormatoMiembroTable = [   { "sWidth": "35%","mDataProp": "int_persona_id"},
                            { "sWidth": "10%","mDataProp": "nombrecompleto"}
                           
                            ]

  ResponsablesTable = createDataTable "table_responsables", root.SourceTServicio, FormatoMiembroTable, null, MiembroRowCB
  PersonaTable = createDataTable "miembros_table", root.SourceTServicio, FormatoMiembroTable, null, MiembroPRowCB


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
    enviar "/informacion_general/guardar_grupos", root.DatosEnviar, MessageSucces, null
    HideForms()

    

  $(".btncancelarform").click (event) ->
    event.preventDefault()
    HideForms()

  $("#reload").click (event) ->
    event.preventDefault()
    PersonaTable.fnReloadAjax root.SourceTServicio