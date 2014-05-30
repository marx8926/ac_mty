# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  count = 0 

  $('#agregar').click (event) ->
    event.preventDefault()
    $("#regniveles_org").show()

  $(".cancelarGuardar").click (event) ->
    event.preventDefault()
    $("form").reset()
    $("#regniveles_org").hide()


  $("form").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000,promptPosition : "topRight", scroll: false}