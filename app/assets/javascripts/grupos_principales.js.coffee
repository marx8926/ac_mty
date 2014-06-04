# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  count = 0

  ResponsablesTable = $('#table_responsables').dataTable
    "aoColumns": [{"mDataProp": "id"},{"mDataProp": "label"}]
    "bPaginate": false
    "sDom": "<r>t<'row-fluid'>"
    "sAjaxSource": "gettablaresponsables_red"
    "fnCreatedRow": (  nRow, aData, iDisplayIndex ) ->
      $(nRow).find('a').tooltip('hide');
      $(nRow).find('.selected').click (e) ->
        index = $(ResponsablesTable.fnGetData()).getIndexObj aData, 'id'
        console.log index


  $("#table_responsables tbody").on "click", "tr", ->
    if $(this).hasClass("selected")
      $(this).removeClass "selected"
      
    else
      ResponsablesTable.$("tr.selected").removeClass "selected"
      $(this).addClass "selected"
      
    return


  PrepararDatosRegistrar = ->
    root.DatosEnviar =
      "formulario" : $("#form_asistencia").serializeObject()  


  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regasistencia").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regasistencia").hide()
