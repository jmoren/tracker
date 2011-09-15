// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $('.tipsy-s').tipsy({gravity: $.fn.tipsy.autoNS});
  $('.tipsy-e').tipsy({gravity: $.fn.tipsy.autoWE,html: true});
  $('.delete_task').click(function(){
    var p = $(this).attr('href')
    id = p.split('/')[2]
    $('#'+id).find('.task').html('<div><img src="/images/loading.gif"> eliminado...</div>')
  });

  $.editable.addInputType('autogrow', {
    element : function(settings, original) {
        var textarea = $('<textarea />');
        if (settings.rows) {
            textarea.attr('rows', settings.rows);
        } else {
            textarea.height(settings.height);
        }
        if (settings.cols) {
            textarea.attr('cols', settings.cols);
        } else {
            textarea.width(settings.width);
        }
        $(this).append(textarea);
        return(textarea);
    },
    plugin : function(settings, original) {
        $('textarea', this).autogrow(settings.autogrow);
    }
  });

});

