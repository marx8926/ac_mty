# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.SourceTServicio = "/recuperar_personas_inicio"
root.DatosEnviar = null
root.count = 0
root.SelectToDrop = null
root.TipoForm = null
root.actionPersonas = null
root.isedit = true

jQuery(document).ready -> 

  $("#form_minist_area").validationEngine 'attach',{autoHidePrompt:true,autoHideDelay:3000}  

  $("#MinsterioAreawizard").bwizard
    nextBtnText: "Siguiente &rarr;"
    backBtnText: "&larr; Anterior"   
   

  ubigeos = getAjaxObject "/ubi.json"
  cargarUbigeo ubigeos, "distrito", "provincia", "departamento"

  PrepararDatosMiembro = ->
    root.DatosEnviar =
      "formulario" : $("#form_minist_area").serializeObject()      

  HideForms = ->   
    $("#minsterioArea").hide()    
    $("form").reset()
    cargarUbigeo ubigeos, "distrito", "provincia", "departamento"  
    aux = root.isedit
    root.isedit = false
    $("#MinsterioAreawizard").bwizard 'show', '0'
    root.isedit = aux
    $("form").enable()

  $('#registrar_ministArea').click (event) ->
    root.isedit = true 
    event.preventDefault()
    HideForms()
    $("#minsterioArea").show()
    $("#btnGuardar_Miembro").show()

  $(".btncancelarform").click (event) ->
    event.preventDefault()
    HideForms()
  
  $("#reload").click (event) ->
    event.preventDefault()
    PersonaTable.fnReloadAjax root.SourceTServicio