root = exports ? this
root.fecha1 = null
root.fecha2 = null
jQuery ->
  Formatomensual =
    [ { "sWidth": "20%","mDataProp": "mes"},
      { "sWidth": "20%","mDataProp": "tiposervicio"},
      { "sWidth": "20%","mDataProp": "servicio"},
      { "sWidth": "20%","mDataProp": "categoria"},
      { "sWidth": "20%","mDataProp": "cantidad"}]

  FormatoGeneral =
    [ { "sWidth": "34%","mDataProp": "tiposervicio"},
      { "sWidth": "33%","mDataProp": "servicio"},
      { "sWidth": "33%","mDataProp": "cantidad"}]

  Tabla_mensual = $("#table_asitencia_mensual").dataTable
    "aoColumns": Formatomensual
    "bAutoWidth": false
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>"
    "sPaginationType": "full_numbers"
    "oLanguage": {
      "sUrl": urlES
    }

  Tabla_General = $("#table_asitencia_general").dataTable
    "aoColumns": FormatoGeneral
    "bPaginate": false
    "bLengthChange": false
    "bSort": false
    "bInfo": false
    "bAutoWidth": false
    "sDom": "<'row-fluid't>"
    "fnDrawCallback": (oSettings ) ->
      setTimeout ->
        $("#totalasistencia").text sumArrayByAttr Tabla_General.fnGetData(), "cantidad"

  $("#btnGenerar_asistencia").click (event) ->
    event.preventDefault()
    Array1fecha = $("#fecha1").val().split "/"
    root.fecha1 = Array1fecha[2]+"-"+Array1fecha[1]+"-"+Array1fecha[0]
    Array2fecha = $("#fecha2").val().split "/"
    root.fecha2 = Array2fecha[2]+"-"+Array2fecha[1]+"-"+Array2fecha[0]
    nombre = "asistencia"+root.fecha1+"_to_"+root.fecha2+".xls"
    Tabla_mensual.fnReloadAjax "/gettablaasistencia/"+root.fecha1+"/"+root.fecha2
    Tabla_General.fnReloadAjax "/gettablaasistenciageneral/"+root.fecha1+"/"+root.fecha2
    $("#btnReporte").attr "href", "/asistenciaexcel/"+root.fecha1+"/"+root.fecha2+"/"+nombre