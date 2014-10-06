if (!ceEditors) var ceEditors = {};
/**
 * @constructor
 */
ceEditors['goto-top-block'] = {

    /** Method: setupEditor */
    setupEditor : function(){
        ceEditors.defaultedt.setupEditor.apply(this);
    },

    /** Method: save */
    save : function(){
        ceEditors.defaultedt.save.apply(this);
        var item = $(this),
            dbid = item.attr('dbid')? item.attr('dbid') : 0,
            dborder = item.attr('dborder')? item.attr('dborder') : 0,
            editor = $(".editor", item);
        item.data("new", false);
        item.removeEditor();

        // post the data to the JSON service
        $.postJSON('/adminpages/services/savediv/format/json/emodule/'+emodule, {
                'id': dbid,
                'order': dborder,
                'content': '',
                'params': '',
                'content_type_label': $(this).data('content-type'),
                'status' : status,
                'pagstructureid' : pagstructureid
            },
            function(data) {
                ceEditors.defaultedt.saveorder(item, data);
                // update the div content
                $.get("/adminpages/services/getdivwitheditor/", {'dbid': data.ResultSet.dbid}, function(data){
                    item.replaceWith(data);
                    $("li[dbid="+item.attr('dbid')+"]").makeEditable();
                });
            }
        );
    }
};