root = exports ? this

jQuery ->

  $("#form_diezmo").change (event) ->
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
    root.DatosEnviar =
      "formulario" : $("#form_diezmo").serializeObject()

  SuccessFunction = ( data ) ->
    console.log data
    if data != null
    	$("#dash_diezmo").highcharts data

  $("#btnGenerar_diezmo").click (event) ->
    event.preventDefault()
    PrepararDatos()
    enviar "recuperar_data_diezmo", root.DatosEnviar, SuccessFunction, null
    
  $("#form_diezmo").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}