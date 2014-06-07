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


  $("form").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "topRight", scroll: false}

  Actions = new DTActions
    'conf' : '000',
    'idtable': 'miembrotable',
    'ViewFunction': (nRow, aData, iDisplayIndex) ->
      
    'DropFunction': (nRow, aData, iDisplayIndex) ->
      root.SelectToDrop = aData.int_persona_id
      DisplayBlockUISingle "dangermodal"

  root.actionMiembros = getActionButtons "000"

  MiembroRowCB = (  nRow, aData, iDisplayIndex ) ->
    Actions.RowCBFunction nRow, aData, iDisplayIndex

  FormatoMiembroTable = [   { "sWidth": "35%","mDataProp": "int_persona_id"},
                            { "sWidth": "10%","mDataProp": "nombrecompleto"}
                           
                            ]

  MiembroTable = createDataTable "miembrotable", root.SourceTServicio, FormatoMiembroTable, null, MiembroRowCB
