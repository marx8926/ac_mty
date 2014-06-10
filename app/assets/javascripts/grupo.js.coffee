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

  $("#form_grupos").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}  

  $("#Grupowizard").bwizard
    nextBtnText: "Siguiente &rarr;"
    backBtnText: "&larr; Anterior"   
   

  ubigeos = getAjaxObject "/ubi.json"
  cargarUbigeo ubigeos, "distrito", "provincia", "departamento"

 
  PrepararDatosMiembro = ->
    root.DatosEnviar =
      "formulario" : $("#form_grupos").serializeObject()
      "tabla" : TelefonoTable.fnGetData()

  HideForms = ->   
    $("#grupo").hide()    
    $("form").reset()
    cargarUbigeo ubigeos, "distrito", "provincia", "departamento"  
    aux = root.isedit
    root.isedit = false
    $("#Grupowizard").bwizard 'show', '0'
    root.isedit = aux
    $("form").enable()


  $('#registrar_grupo').click (event) ->
    root.isedit = true 
    event.preventDefault()
    HideForms()
    $("#grupo").show()

  $(".btncancelarform").click (event) ->
    event.preventDefault()
    HideForms()

  $("#reload").click (event) ->
    event.preventDefault()
    PersonaTable.fnReloadAjax root.SourceTServicio