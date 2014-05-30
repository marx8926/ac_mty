root = exports ? this

jQuery ->
  
  $("#form_asistencia").change (event) ->
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
    console.log $("#form_asistencia").serializeObject()
    root.DatosEnviar =
      "formulario" : $("#form_asistencia").serializeObject()

  SuccessFunction = ( data ) ->
    console.log data
    if data.length == 6
      $("#dash_general_lineas").highcharts data[0]    
      $("#dash_general_pie").highcharts data[1]
      #$("#dash_mujeres_joven").highcharts data[2]
      #$("#dash_hombres_joven").highcharts data[3]
      #$("#dash_mujeres_adulto").highcharts data[4]
      #$("#dash_hombres_adulto").highcharts data[5]
    if data.length == 2
      $("#dash_general_lineas").highcharts data[0]
      $("#dash_general_pie").highcharts data[1]
    if data.length == 1
      $("#dash_general_pie").html("")
      $("#dash_general_lineas").highcharts data[0]

  $("#btnGenerar_asistencia").click (event) ->
    event.preventDefault()
    if $("#form_asistencia").validationEngine 'validate'
      PrepararDatos()
      enviar "/recuperar_data_asistencia", root.DatosEnviar, SuccessFunction, null

  $("#form_asistencia").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}