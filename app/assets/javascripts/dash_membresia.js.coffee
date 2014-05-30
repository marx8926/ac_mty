#datos_miembros = getAjaxObject "data_miembro"
#datos_visita = getAjaxObject "data_visitante"
#datos_pie = getAjaxObject "data_pie"

#$("#dash_miembro_lineas").highcharts datos_miembros
#$("#dash_visita_lineas").highcharts datos_visita
#$("#dash_pie_membresia").highcharts datos_pie

#$("#form_membresia").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}


root = exports ? this

jQuery ->
  
  $("#form_membresia").change (event) ->
    if $("#mes").is ':checked'
      $('#mes_lista').prop 'disabled',false
    else
      $('#mes_lista').prop 'disabled','disabled'
      $('#mes_lista').val 0

  PrepararDatos = ->
    root.DatosEnviar =
      "formulario" : $("#btnGenerar_membresia").serializeObject()
    console.log "preparar"

  SuccessFunction = ( data ) ->
    console.log data 
    if data != null
      $("#dash_miembro_lineas").highcharts data[0]
      $("#dash_visita_lineas").highcharts data[1]
      $("#dash_pie_membresia").highcharts data[2]

  $("#btnGenerar_membresia").click (event) ->
    event.preventDefault()
    PrepararDatos()
    enviar "/recuperar_data_ofrenda", root.DatosEnviar, SuccessFunction, null

  #datos_ofrenda = getAjaxObject "recuperar_data_ofrenda"
  #$("#dash_ofrenda_barras").highcharts datos_ofrenda
    $("#form_membresia").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}