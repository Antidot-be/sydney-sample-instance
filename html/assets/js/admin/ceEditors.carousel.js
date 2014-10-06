if (!ceEditors) var ceEditors = {};
/**
 * @constructor
 */
ceEditors['carousel-block'] = {
	/**
	 * Method: save
	 */
	save : function(e){
		ceEditors.defaultedt.save.apply(this);

        var item = $(this),
            dbid = item.attr('dbid') || 0,
            dborder = item.attr('dborder') || 0,
            editor = $(".editor", item),
            elementsIds = [];

        if( $("#folders-categories").length == 0 ) {
            $('.itemselected', editor).each(function(){
                elementsIds.push( $(this).attr('href') );
            });
        }
        item.data('new', false);
        item.removeEditor();

        $.postJSON('/adminpages/services/savediv/format/json/emodule/'+emodule, {
                'id': dbid,
                'order': dborder,
                'content': elementsIds.toString(),
                'params': '',
                'content_type_label': $(this).data('content-type'),
                'status' : status,
                'pagstructureid' : pagstructureid
            },
            function(data) {
                ceEditors.defaultedt.saveorder( item, data);
                $.get("/adminpages/services/getdivwitheditor/", {'dbid': data.ResultSet.dbid}, function(data){
                    item.replaceWith(data);
                    $("li[dbid="+item.attr('dbid')+"]").makeEditable();
                });
            }
        );
	},
	/**
	 * Method: setupEditor
	 */
	setupEditor : function(){
		ceEditors.defaultedt.setupEditor.apply(this);
		var item = $(this),
            previousElements = $('.preview-image'),
            previousIds = [];

        previousElements.each(function(){
            previousIds.push($(this).data('file-id'));
        });
        $(".editor", item).load(
            "/adminfiles/index/index/",{
                'embed':'yes',
                'context': 'pageeditor',
                'filter' : 1,
                'mode' : 'thumb',
                'selected_files': previousIds
            }, function(e) {
                $('.buttons .button').click(function(e){
                    e.preventDefault();
                    var action = $(this).attr('href');

                    if (action == "save") {
                        status 	= 'published';
                    } else if (action == "save-draft") {
                        status 	= 'draft';
                        action 	= "save";
                    }
                    item[action]();
                });
            }
        );

	}
};