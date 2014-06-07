
/*Extensiones de jQuery*/

jQuery.fn.getIndexObj = function (obj,attr){
	var objindex = null;
	this.each(function( index ) {
		  if(this[attr] == obj[attr]){
			  objindex = index;
		  }
	});
	return objindex;
};

jQuery.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};


jQuery.fn.reset = function () {
	  $(this).each (function() { this.reset(); });
	};

jQuery.fn.disable = function () {
	  $(this).find("input,select,textarea,checkbox").attr("disabled",true);
	};

jQuery.fn.enable = function () {
	  $(this).find("input,select,textarea,checkbox").attr("disabled",false);
	};

//Validar formularion con Wizard (esta en desuso)
// Requiere jQuery.validationEngine v2.6.1 https://github.com/posabsolute/jQuery-Validation-Engine
/*function validateForm(form, num) {
  var band, i;
  band = true;
  i = 0;
  while (i < num) {
    $(".wizard").bwizard('show', i);
    if (!$("#"+form).validationEngine('validate')) {
      band = false;
      break;
    }
    i++;
  }
  return band;
};*/


/*Fin extensiones de jQuery*/
function getActionButtons(conf){
  actions = "<p>"
  if(conf.substring(0,1)==1)
    actions += '<a class="ver_row actions-icons" data-original-title="Ver" href="#"><img alt="ver" class="icons" src="view.png"></a>';
  else if(conf.substring(1,2)==1)
    actions += '<a class="edit_row actions-icons" data-original-title="Editar" href="#"><img alt="edit" class="icons" src="/images/edit-icon.png"></a>';
  else if(conf.substring(2,3)==1)
    actions += '<a class="delete-row actions-icons" data-original-title="Eliminar" href="#"><img alt="trash" src="/images/trash-icon.png"></a>';
  else if(conf.substring(3,4)==1)
    actions += '<a class="select-row actions-icons" data-original-title="Select" href="#"><img alt="select" src="/images/select2.png"></a>';

  actions += '</p>'
  return actions;
}

function getConfOneDay(day)
{
	var conf = "";
	for(var i = 0 ; i < 7 ; i++)
	{
		if(i===parseInt(day))
			continue;
		conf+=i
		if(i!=6)
			conf+=","
	}
	return conf;
}

function getDiaSemana(num){
  var dia;
  switch (parseInt(num)){
    case 0:
      dia = "Domingo";
      break;
    case 1:
      dia = "Lunes";
      break;
    case 2:
      dia = "Martes";
      break;
    case 3:
      dia = "Miercoles";
      break;
    case 4:
      dia = "Jueves";
      break;
    case 5:
      dia = "Viernes";
      break;
    case 6:
      dia = "Sabado";
      break;
  }
  return dia;
}

function DisplayBlockUI(idMensaje){
  $.blockUI({
    message: $('#'+idMensaje),
    css: {
      border: 'none',
      padding: '15px',
      backgroundColor: '#000',
      '-webkit-border-radius': '10px', 
      '-moz-border-radius': '10px',
      opacity: .5,
      color: '#fff'
      }
    });
}

function DisplayBlockUISingle(idMensaje){
   $.blockUI({
    message: $('#'+idMensaje),
    css: {
      border: 'none'
    }
  });
}


/*
 * logdata : muestra la data que se devuelve como response al enviar un formulario
 * con la funcion enviar
 */
var logdata = function(data){
	console.log(data);
	};

/*
 * reloadpage : recarga la pagina actual
 */
var reloadpage = function(data){
	location.reload();
	};
	
function AddAttr(Array, attr, value){
	$(Array).each(function( index ){
		this[attr] = value;
	});
}

function CloneAttr(Array, attr1, attr2){
	$(Array).each(function( index ){
		var value =this[attr1];
		this[attr2] = value;
	});
}

function CloneAttrTable(Tabla, attr, pos){
	var Array = Tabla.fnGetData();
	$(Array).each(function( index ){
		CuotasTable.fnUpdate(this[attr],index,pos);
	});
}
	
function getMultipleSelectRowCallBack(DSelected){
	var SelectRowFunction = function(nRow,aData,iDisplayIndex){
		$(nRow).click( function() {
			$(this).toggleClass('row_selected');
			if($(this).hasClass('row_selected'))
				DSelected.push(aData);
			else{
				var removeindex = $(DSelected).getIndexObj(aData,'id');
				DSelected.splice(removeindex,1);
			}
		});
	};
	
	return SelectRowFunction;
}

function UnselectRow(idTable){
	$("#"+idTable+" tr").each(function(index){
		if($(this).hasClass("row_selected"))
			$(this).toggleClass('row_selected');
	});
}

function SubTablaArray(Table, Array, attr){
	$(Array).each(function( index ){
		var indexarray = $(Table.fnGetData()).getIndexObj(this,attr);
		Table.fnDeleteRow( indexarray );
	});
}

/*
 * Nesesita tener definido el atributo cantidad
 */
function sumArrayByAttr(Array2,attr){
	var total = 0;
	$(Array2).each(function( index ){		
		total +=parseFloat(this[attr]);	
	});
	return(total);
}

function getSimpleSelectRowCallBack(DSelected, tableid){
	var SelectRowFunction = function(nRow,aData,iDisplayIndex){
		$(nRow).click( function() {
			if ( $(this).hasClass('row_selected') ) {
	            $(this).removeClass('row_selected');
	            DSelected.pop();
	        }
			else {
				$('#'+tableid+' tr.row_selected').removeClass('row_selected');
	            $(this).addClass('row_selected');
	            DSelected.pop();
	            DSelected.push(aData);
	        }
		});
	};
	
	return SelectRowFunction;
}
	
/*
 * enviar : envia un formulario con los datos serializado a un controlador, los formularios deben estar presentes
 * y se debe utiliza en la funcion ready del documento
 * IdForm : es el id del formulario a enviar
 * responsefunction : es la funcion que se ejecuta cuando responde el controlador
 * otherdata: son datos adicionales que se pueden enviar al controlador
 */
function enviar(url, datos, successfunction, errorfunction){
	var Consulta = $.ajax({
		type: "POST",		
      	dataType: "JSON",
		url: url,
		data: datos
  	});


    if(typeof(successfunction)!= 'undefined' && successfunction != null)
    	Consulta.done(function(data){
    		successfunction(data);
    	});

    if(typeof(errorfunction)!= 'undefined' && errorfunction != null)
    	Consulta.fail(function(data){
    		errorfunction(data);
    	});

		
}

/*
 * Crea un datatable y lo devuelve como variable
 */
function createDataTable(idTable,UrlaDTable,FormatoDTable, DrawCallBackFunction, RowCallBackFunction){
	
	var oTable = $('#'+idTable).dataTable({
		"bProcessing": false,
		"bDestroy": true,		
        "bSort": false,
		"sAjaxSource": UrlaDTable,	  
		"aoColumns": FormatoDTable,				   
    	"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>",
    	"sPaginationType": "full_numbers",
    	"oLanguage": {
    		"sUrl": urlES
    	},  
	 	"fnCreatedRow": function( nRow, aData, iDisplayIndex ) {
	 		if(typeof(RowCallBackFunction)!= 'undefined' && RowCallBackFunction != null)
	 			RowCallBackFunction(nRow,aData,iDisplayIndex);
		},
	 	"fnDrawCallback": function(oSettings ){
		 	if(typeof(DrawCallBackFunction)!= 'undefined' && DrawCallBackFunction != null){
		 		setTimeout(function() {
			 		DrawCallBackFunction();
		 		});
	 		}
    }
	});
	return oTable;
}

function CopyArray(Array1,Array2,all,attrs){
	while(Array1.length > 0)
		Array1.pop();	
	if(all){
		$(Array2).each(function( index ){
			Array1.push(this);
		});
	}
	else{
		$(Array2).each(function( index ){
			var olddata = this;
			var newdata = [];
			var jsondata = '{';
			for(var i=0; i<attrs.length;i++){
				jsondata +='"'+attrs[i]+'":"'+olddata[attrs[i]]+'"';
				if(attrs.length-1>i)
					jsondata = jsondata + ',';
			}
			jsondata += '}';
			newdata = jQuery.parseJSON(jsondata);
			Array1.push(newdata);
		});
	}
}

function getAjaxObject(url){
	var data = $.ajax({
		url: url,
		dataType: "json",
		async: false
		}).responseText;
	return jQuery.parseJSON(data);
}
function ajaxResponseData(namediv,path){
	var data = $.ajax({
        url: path,
        async: false
        }).responseText;
	$('#'+namediv).html(data);
}

function ajaxResponseDataPost(namediv,path){
	var data = $.ajax(
            {
                url: path,
                async: false,
                type: "POST",
            }).responseText;
	$('#'+namediv).html(data);
}

function ajaxTableDataPost(nametable,path)
{
        $.ajax(
            {
            url: path,
            async: false,
            type: "POST",
            }).done(function(data){
                $('#'+nametable+'> tbody:last').append(data);
            });
}
function ajaxListPost(path,select,red)
{   
    $.post(path,{dato:red},function(data){
         $('#'+select).html(data);
    });
   
}

function SelectListPost(list, valor)
{
    $('#'+list).val(valor);
}
	
function reloadTable(oTable){
	var returnfunction = function(data){
		oTable.fnReloadAjax();
		console.log(data);
		};
	return returnfunction;
}

function reloadclosemodal(idmodal,idaTable){
	var returnfunction = function(data){
		$('#'+idaTable).dataTable().fnReloadAjax();
		console.log(data);
		$('#'+idmodal).modal('hide');
		$('#'+idmodal+" form").reset();
		};
	return returnfunction;
}
	
/*Funcion para crear los formularios de forma dinamica*/
function crearElementosForm(Array){
	var $form = $("<div>");
	var $modalfooter = $("<div class='modal-footer'>");
	var $modalbody = $("<div class='modal-body'>");
	var $fielset = $("<fieldset>");
	jQuery.each(Array, function() {
		switch (this.type){
		case 'h3':
			$fielset.append('<h3>'+this.label+'</h3>');
			break;
		case 'actions':
			$modalfooter.append('<button type="reset" class="btn" data-dismiss="modal">Cancelar</button>  <button type="submit" class="btn btn-primary">Guardar</button>');
			break;
		case 'close':
			$modalfooter.append('<button type="reset" class="btn" data-dismiss="modal">Cerrar</button>');
			break;
		case 'hidden':
			$fielset.append('<input type="hidden" name="'+this.name+'" value="'+this.value+'">');
			break;
		default:
			$div_control_group = $('<div class="control-group">');
			$div_control_group.append('<label class="control-label" for="zona">'+this.label+'</label>');
			$div_control = $('<div class="controls">');
			$div_control.append(addElemento(this));
			$div_control_group.append($div_control);
			$fielset.append($div_control_group);
			$modalbody.append($fielset);
			break;
		}
	   });
	$form.append($modalbody);
	$form.append($modalfooter);
	
	return $form;
}

function addElemento(obj){
	switch (obj.type) {
	    case 'input': 
	    		$elem = $('<input class="input-xlarge focused" id="'+obj.name+'" name="'+obj.name+'" type="'+obj.typeinput+'" pattern="'+obj.pattern+'" title="'+obj.title+'" required="'+obj.req+'" maxlength="'+obj.max+'">');
	    		$elem.val(obj.value);
	    		break;
	    case 'inputnumber':
		    	$elem = $('<input class="input-xlarge focused" id="'+obj.name+'" name="'+obj.name+'" type="number" required="'+obj.req+'" step="'+obj.step+'" min="'+obj.min+'" max="'+obj.max+'">');
	    		$elem.val(obj.value);
	    		break;
	    case 'file':
	    		$elem = $('<input type="file" class="input-xlarge" name="'+obj.name+'">');
	    		break;
	    case 'textarea':
	    		$elem = $('<textarea class="input-xlarge" name="'+obj.name+'" rows="2" cols="" required="'+obj.req+'" maxlength="'+obj.max+'"></textarea>');
	    		$elem.val(obj.value);
	    		break;
	    case 'date':
	    		$elem = $('<input type="text" class="input-xlarge datepicker" id="'+obj.name+'" name="'+obj.name+'" value="'+obj.value+'">');
	    		break;
	    case 'select':
	    		$elem  = $('<select id="'+obj.name+'" name="'+obj.name+'" data-rel="chosen" >');
	    		break;
	    case 'img':
	    		$elem = $('<figure><img src="'+obj.value+'" alt="Tarjeta"></figure>');
	    		break;
	    case 'span': 
	    		$elem = $('<span class="help-inline" style="margin-top:5px;">'+obj.value+'</span>');
	    		break;
	}	
	return $elem;
}	

/*--------------------------------UBIGEO------------------------------------*/
function cargarDep(idselect, ubigeo){
	var $select = $('#'+idselect);
	var result = '';
	$(ubigeo).each(function(){
		if(this.int_ubigeo_departamento == 1)
			result += '<option value="'+this.int_ubigeo_id+'">'+this.string_ubigeo_descripcion+'</option>';
	});
	$select.html(result); 
}

function cargarProv(idselect, ubigeo, iddepend){
	var $select = $('#'+idselect);
	var result = '';
	$(ubigeo).each(function(){
		if(this.int_ubigeo_provincia == 1 && this.int_ubigeo_dependencia == iddepend)
			result += '<option value="'+this.int_ubigeo_id+'">'+this.string_ubigeo_descripcion+'</option>';
	});
	$select.html(result); 
}

function cargarDist(idselect, ubigeo, iddepend){
	var $select = $('#'+idselect);
	var result = '';
	$(ubigeo).each(function(){
		if(this.int_ubigeo_distrito == 1 && this.int_ubigeo_dependencia == iddepend)
			result += '<option value="'+this.int_ubigeo_id+'">'+this.string_ubigeo_descripcion+'</option>';
	
	});
	$select.html(result); 
}

function cargarUbigeo(ubigeos, idtagdist, idtagprov, idtagdep, iddist, idprov, iddep){
	
	cargarDep(idtagdep, ubigeos);

	if(typeof(iddep) != 'undefined'){
		$('#'+idtagdep).val(iddep);
	}

	cargarProv(idtagprov, ubigeos, $('#'+idtagdep).val());

	if(typeof(idprov) != 'undefined'){
		$('#'+idtagprov).val(idprov);
	}

	cargarDist(idtagdist, ubigeos, $('#'+idtagprov).val());

	if(typeof(iddist) != 'undefined'){
		$('#'+idtagdist).val(iddist);
	}
	
	$('#'+idtagdep).change(function(){
		cargarProv(idtagprov, ubigeos, $('#'+idtagdep).val());

		cargarDist(idtagdist, ubigeos, $('#'+idtagprov).val());
	});

	$('#'+idtagprov).change(function(){
		cargarDist(idtagdist, ubigeos, $('#'+idtagprov).val());
	});
}
/*--------------------------------FIN UBIGEO------------------------------------*/

function cargarSelect(arreglo, idselect, attrvalue, attrdescripcion){
	var $select = $('#'+idselect);
	var result = '';
	
	$(arreglo).each(function(){
		result += '<option value="'+this[attrvalue]+'">'+this[attrdescripcion]+'</option>';		
	});
	$select.html(result);
}
/*------------------------------FECHAAAA------------------------------------------*/
function fechaAhora(){
	date = new Date();
	dia = '';
	mes = '';
	if(date.getDate() < 10)
		dia = '0'+ (date.getDate());
	else
		dia = date.getDate();
	if(date.getMonth()+1 < 10)
		mes = '0'+ (date.getMonth() + 1);
	else
		mes = (date.getMonth() + 1);
	fecha = dia + "/" + (mes) + "/" + date.getFullYear();
	return fecha;
}

function toHTML(element){
	var div = $("<div>");
	div.append(element);
	return div.html();
}

/*-------------------------------- Crear Tabla ------------------------------------*/
function crearTablaToArray(Head,Attr,Array){
	var table = $("<table>");
	var thead = $("<thead>");
	var tbody = $("<tbody>");
	var trh = $("<tr>");
	for (var i = 0 ; i< Head.length ; i++){
		trh.append("<td>"+Head[i]+"</td>");
	}
	
	$(Array).each(function(index){
		var trb = $("<tr>");
		for(var j = 0 ; j < Attr.length ; j++){
			trb.append("<td>"+this[Attr[j]]+"</td>");
		}
		tbody.append(trb);
	});
	thead.append(trh);
	table.append(thead);
	table.append(tbody);
	return table;
}