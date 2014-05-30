root = exports ? this
root.fecha1 = null
root.fecha2 = null
root.personaselected = 0
jQuery(document).ready ->
  personas = getAjaxObject "/persona_servicio_complete"
  $("#persona").autocomplete
    source: personas
    delay: 1
    open: (event, ui) ->
      root.personaselected = 0
    select: (event, ui) ->
      event.preventDefault()
      $("#persona").val ui.item.label
      root.personaselected = ui.item.int_persona_id

  $("#checkpersona").change (event) ->
    event.preventDefault()
    if $("#checkpersona").is ':checked'
      $('#persona').prop 'disabled',false
    else
      $('#persona').val ""
      root.personaselected = 0
      $('#persona').prop 'disabled','disabled'

	FormatoDiezmo =
    [ { "sWidth": "20%","mDataProp": "Miembro"},
      { "sWidth": "5%","mDataProp": "fecharegistro"},
      { "sWidth": "10%","mDataProp": "peticion"}
      { "sWidth": "10%","mDataProp": "monto"},]

  Tabla_Diezmo = $("#table_diezmo").dataTable
    "aoColumns": FormatoDiezmo
    "bAutoWidth": false
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>"
    "sPaginationType": "full_numbers"
    "oLanguage": {
      "sUrl": urlES
    }
    "fnDrawCallback": (oSettings ) ->
      setTimeout ->
        $("#totaldiezmo").text sumArrayByAttr Tabla_Diezmo.fnGetData(), "monto"

  $("#btnGenerar_diezmo").click (event) ->
    event.preventDefault()
    Array1fecha = $("#fecha1").val().split "/"
    root.fecha1 = Array1fecha[2]+"-"+Array1fecha[1]+"-"+Array1fecha[0]
    Array2fecha = $("#fecha2").val().split "/"
    root.fecha2 = Array2fecha[2]+"-"+Array2fecha[1]+"-"+Array2fecha[0]
    if $("#persona").val() != ""
      nombremiembro = $("#persona").val().replace " ", "_"
    else
      nombremiembro = "diezmos"
    nombre = nombremiembro+root.fecha1+"_to_"+root.fecha2+".xls"
    Tabla_Diezmo.fnReloadAjax "/gettabladiezmo/"+root.fecha1+"/"+root.fecha2+"/"+root.personaselected
    $("#btnReporte").attr "href", "/diezmosexcel/"+root.fecha1+"/"+root.fecha2+"/"+root.personaselected+"/"+nombre