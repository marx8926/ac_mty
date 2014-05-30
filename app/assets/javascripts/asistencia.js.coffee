# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.SourceTAsistencia = "/recuperar_asistencia"


jQuery ->
  count = 0

  categorias = getAjaxObject "/getcategorias"

  cargarSelect categorias, "categoria", "int_constante_valor","var_constante_descripcion" 

  MessageSucces = ->
    setTimeout (->
      $.unblockUI onUnblock: ->
        $.growlUI "Operacion Exitosa"

    ), 1000

  PrepararDatosRegistrar = ->
    root.DatosEnviar =
      "formulario" : $("#form_asistencia").serializeObject()
      "tabla" : CategoriaTable.fnGetData()

  # Funcion de respuesta CORRECTA
  # Los datos de respuesta se reciben en data
  SuccessFunctionRegistrar = ( data ) ->
    MessageSucces()
    AsistenciaTable.fnReloadAjax root.SourceTAsistencia
    $("form").reset()
    CategoriaTable.fnClearTable()    
    $("#regasistencia").hide()

  ReloadDatePicker = ->
    $("#fecha").datepicker
      format: "dd/mm/yyyy"
      language: "es"
      endDate: new Date()
      autoclose: true
      todayHighlight: true
      orientation: "top auto"
      daysOfWeekDisabled: getConfOneDay getAjaxObject "/get_dia_servicio/"+$("#_servicio").val()
      
  if($("#_servicio").val()!= null)
    ReloadDatePicker()

  CategoriaTable = $('#table_categoria_asistencia').dataTable
    "aoColumns": [{"mDataProp": "servicio"},{"mDataProp": "categoria"},{"mDataProp": "asistente"},{"mDataProp": "accion"}]
    "bPaginate": false
    "sDom": "<r>t<'row-fluid'>"
    "fnCreatedRow": (  nRow, aData, iDisplayIndex ) ->
      $(nRow).find('.delete-row').click (e) ->
        index = $(CategoriaTable.fnGetData()).getIndexObj aData, 'id'
        CategoriaTable.fnDeleteRow index


  $('#agregar_asistentes').click (event) ->
    event.preventDefault()
    if !$("#asistentes").validationEngine 'validate'
      categoria =
        "servicio": $("#_servicio option:selected").text()
        "categoria" : $("#categoria option:selected").text()
        "asistente": $("#asistentes").val()
        "accion":getActionButtons "001"
        "id":count
        "servicioid": $("#_servicio").val()
        "categoriaid": $("#categoria").val()
      CategoriaTable.fnAddData categoria
      count--

  $("#_servicio").change (event) ->
    event.preventDefault()
    $("#fecha").val ""
    $("#fecha").datepicker 'remove'
    ReloadDatePicker()

  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regasistencia").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regasistencia").hide()
    CategoriaTable.fnClearTable

  AsistenciaFormato = [   { "sWidth": "35%","mDataProp": "servicio"},
                        { "sWidth": "15%","mDataProp": "fecha"},
                        { "sWidth": "25%","mDataProp": "turno"},
                        { "sWidth": "20%","mDataProp": "asistencia"}
                        ]

  AsistenciaTable = createDataTable "table_asistencia", root.SourceTAsistencia, AsistenciaFormato, null, null
  
  # 2. Enviar Datos
  $("#btnGuardar_Asistencia").click (event) ->
    event.preventDefault()
    if CategoriaTable.fnSettings().fnRecordsTotal() > 0
      if $("form").validationEngine 'validate'
        PrepararDatosRegistrar()
        DisplayBlockUI "loader"
        enviar "/asistencia_guardar", root.DatosEnviar, SuccessFunctionRegistrar, null
    else
      alert "Nesesita agregar datos a la Tabla"

  $("form").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "topRight", scroll: false}