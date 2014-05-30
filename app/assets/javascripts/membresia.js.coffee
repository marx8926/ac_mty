root = exports ? this
root.fecha1 = null
root.fecha2 = null
jQuery(document).ready ->

  FormatoMiembro =
    [ { "sWidth": "20%","mDataProp": "nombrecompleto"},
      { "sWidth": "5%","mDataProp": "edad"},
      { "sWidth": "10%","mDataProp": "fecconvertido"},
      { "sWidth": "10%","mDataProp": "fecnacimiento"},
      { "sWidth": "10%","mDataProp": "var_persona_ocupacion"},
      { "sWidth": "10%","mDataProp": "direccion"},
      { "sWidth": "10%","mDataProp": "referencias"},
      { "sWidth": "10%","mDataProp": "telefono"}]

  Tabla_Miembros = $("#table_asitencia_miembro").dataTable
    "aoColumns": FormatoMiembro
    "bAutoWidth": false
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>"
    "sPaginationType": "full_numbers"
    "oLanguage": {
      "sUrl": urlES
    }

  FormatoVisitante =
    [ { "sWidth": "20%","mDataProp": "nombrecompleto"},
      { "sWidth": "5%","mDataProp": "edad"},
      { "sWidth": "10%","mDataProp": "fecnacimiento"},
      { "sWidth": "10%","mDataProp": "telefono"}]

  Tabla_Visistante = $("#table_asitencia_visitante").dataTable
    "aoColumns": FormatoVisitante
    "bAutoWidth": false
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>"
    "sPaginationType": "full_numbers"
    "oLanguage": {
      "sUrl": urlES
    }

  $("#btnGenerar_asistencia").click (event) ->
    event.preventDefault()
    Array1fecha = $("#fecha1").val().split "/"
    root.fecha1 = Array1fecha[2]+"-"+Array1fecha[1]+"-"+Array1fecha[0]
    Array2fecha = $("#fecha2").val().split "/"
    root.fecha2 = Array2fecha[2]+"-"+Array2fecha[1]+"-"+Array2fecha[0]
    if $("#options input[type='radio']:checked").val() == "option1"
      nombre = "miembros_"+root.fecha1+"_to_"+root.fecha2+".xls"
      $("#widgetMiembro").show()
      $("#widgetVisitante").hide()
      Tabla_Miembros.fnReloadAjax "/gettablamiembro/"+root.fecha1+"/"+root.fecha2
      $("#btnReporte").attr "href", "/miembrosexcel/"+root.fecha1+"/"+root.fecha2+"/"+nombre
    else
      nombre = "visitantes"+root.fecha1+"_to_"+root.fecha2+".xls"
      $("#widgetVisitante").show()
      $("#widgetMiembro").hide()
      Tabla_Visistante.fnReloadAjax "/gettablavisitante/"+root.fecha1+"/"+root.fecha2
      $("#btnReporte").attr "href", "/visitantesexcel/"+root.fecha1+"/"+root.fecha2+"/"+nombre