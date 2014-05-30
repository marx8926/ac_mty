root = exports ? this

jQuery ->
  
  $("#form_ofrenda").change (event) ->
    if $("#mes").is ':checked'
      $('#mes_lista').prop 'disabled',false
    else
      $('#mes_lista').prop 'disabled','disabled'
      $('#mes_lista').val 0
      $("#semanadiv").hide()
      $("#semana").prop 'checked', false
      $('#semana_lista').prop 'selectedIndex',0

    if $("#mes_lista").val() == '0'
      $("#semanadiv").hide()
    else
      $("#semanadiv").show()

    if $("#semana").is ':checked'
      $('#semana_lista').prop 'disabled',false
    else
      $('#semana_lista').prop 'disabled','disabled'
      $('#semana_lista').prop 'selectedIndex',0

  PrepararDatos = ->
    console.log $("#form_ofrenda").serializeObject()
    root.DatosEnviar =
      "formulario" : $("#form_ofrenda").serializeObject()
    console.log "preparar"

  SuccessFunction = ( data ) ->
    console.log data 
    if data != null
      $("#dash_ofrenda_barras").highcharts data

  $("#btnGenerar_ofrenda").click (event) ->
    event.preventDefault()
    PrepararDatos()
    enviar "/recuperar_data_ofrenda", root.DatosEnviar, SuccessFunction, null

  #datos_ofrenda = getAjaxObject "recuperar_data_ofrenda"
  #$("#dash_ofrenda_barras").highcharts datos_ofrenda
    $("#form_ofrenda").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}