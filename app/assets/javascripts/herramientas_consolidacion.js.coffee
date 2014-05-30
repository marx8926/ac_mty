# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.SourceTAsistencia = "/recuperar_asistencia"


jQuery ->
  count = 0



  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regasistencia").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regasistencia").hide()
    CategoriaTable.fnClearTable



  $("form").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "topRight", scroll: false}