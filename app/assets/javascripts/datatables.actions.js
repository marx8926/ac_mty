function DTActions(options)
{
	var divaction = $("<div class='actions'>");
	var divbubble = $("<div class='action-bubble'>");
	var divcontainer = $("<div class='action_container'>");
	var ul = $(getButtons(options.conf));

	divaction.append(divbubble);
	divbubble.append(divcontainer);
	divcontainer.html(ul);

	var count = ul.find("li").length;

	switch(count)
	{
		case 1:
			divcontainer.css("height","26px");
			divbubble.css("height","34px");
			break;
		case 2:
			divcontainer.css("height","54px");
			divbubble.css("height","62px");
			break;
		case 3:
			divcontainer.css("height","82px");
			divbubble.css("height","91px");
			break;
	}

	this.RowCBFunction = function( nRow, aData, iDisplayIndex )
	{
    	$(nRow).click( function(e)
    	{
    		e.preventDefault();
    		var tr = $(this);
			if ( tr.hasClass('row_selected') ) {
	            tr.removeClass('row_selected');
	            divaction.remove();	            
	            IdReservaSelected = null;
	        }
			else {
				divaction.show();
				var tds = $(this).find("td");
				$($("#"+options.idtable).dataTable().fnGetNodes()).removeClass('row_selected');
	            tr.addClass('row_selected');
	            $(tds[tds.length-1]).append(divaction);


				ul.find(".btn-view").click(function(e){
					e.preventDefault();
					options.ViewFunction(nRow, aData, iDisplayIndex);
				});
				ul.find(".btn-edit").click(function(e){
					e.preventDefault();
					options.EditFunction(nRow, aData, iDisplayIndex);
				});
				ul.find(".btn-drop").click(function(e){
					e.preventDefault();
					options.DropFunction(nRow, aData, iDisplayIndex);
				});

				ul.find(".btn-select").click(function(e){
					e.preventDefault();
					options.SelectFunction(nRow, aData, iDisplayIndex)
				});
        	}
		});
    };

}

function getButtons(conf){
	actions = "<ul>";
	if(conf.substring(0,1)==1)
		actions += '<li><button class="btn btn-default btn-action btn-view"><img alt="ver" class="icons" src="/view.png"></button></li>';
	if(conf.substring(1,2)==1)
		actions += '<li><button class="btn btn-default btn-action btn-edit"><img alt="edit" class="icons" src="/images/edit-icon.png"></button></li>';
	if(conf.substring(2,3)==1)
		actions += '<li><button class="btn btn-default btn-action btn-drop"><img alt="trash" src="/images/trash-icon.png"></button></li>';
	if(conf.substring(3,4)==1)
		actions += '<li><button class="btn btn-default btn-action btn-select" data-dismiss="modal" type= "button"><img alt="select" src="/images/select2.png"></button></li>';
	
	actions += '<ul>';
	return actions;
}