root = exports ? this
root.fecha1 = null
root.fecha2 = null
jQuery ->
	FormatoOfrenda =
    [ { "sWidth": "20%","mDataProp": "tiposervicio"},
      { "sWidth": "5%","mDataProp": "servicio"},
      { "sWidth": "10%","mDataProp": "fecha"},
      { "sWidth": "10%","mDataProp": "turno"},
      { "sWidth": "10%","mDataProp": "monto"}]

  Tabla_Ofrendas = $("#table_ofrendas").dataTable
    "aoColumns": FormatoOfrenda
    "bAutoWidth": false
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>"
    "sPaginationType": "full_numbers"
    "oLanguage": {
      "sUrl": urlES
    }
    "fnDrawCallback": (oSettings ) ->
      setTimeout ->
        $("#totalofrendas").text sumArrayByAttr Tabla_Ofrendas.fnGetData(), "monto"

  $("#btnGenerar_ofrendas").click (event) ->
    event.preventDefault()
    Array1fecha = $("#fecha1").val().split "/"
    root.fecha1 = Array1fecha[2]+"-"+Array1fecha[1]+"-"+Array1fecha[0]
    Array2fecha = $("#fecha2").val().split "/"
    root.fecha2 = Array2fecha[2]+"-"+Array2fecha[1]+"-"+Array2fecha[0]
    servicio = $("#_idservicio option:selected").text().replace " ","_"
    nombre = servicio+root.fecha1+"_to_"+root.fecha2+".xls"
    Tabla_Ofrendas.fnReloadAjax "/gettablaofrenda/"+root.fecha1+"/"+root.fecha2+"/"+$("#_servicio").val()
    $("#btnReporte").attr "href", "/ofrendaesexcel/"+root.fecha1+"/"+root.fecha2+"/"+$("#_servicio").val()+"/"+nombre