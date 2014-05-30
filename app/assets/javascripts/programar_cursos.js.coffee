# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  count = 0

  PrepararDatosRegistrar = ->
    root.DatosEnviar =
      "formulario" : $("#form_programarcursos").serializeObject()
 

  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regProgramar_cursos").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regProgramar_cursos").hide()