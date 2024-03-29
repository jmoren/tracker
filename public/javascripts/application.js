// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $(function(){
    $("*[data-placeholder]").bind('focus', unhold );
    $("*[data-placeholder]").bind('blur', hold );
    $("*[data-placeholder]").each(hold);
  });

  $("a[rel*=facebox]").facebox({
      loadingImage : '/images/loader.gif',
      closeImage   : '/images/closelabel.png',
    });
  $('.remove_activity').click(function(){
      var id = $(this).attr('id');
      $('#activity_'+id + ' .resume').html("<img style='margin: -4px 5px' src='/images/loading.gif'> removeing activity ");
    });
  $('.tipsy-s').tipsy({gravity: 's'});
  $('.tipsy-n').tipsy({gravity: 'n'});
  $('.tipsy-e').tipsy({gravity: 'e',html: true});
  $('.tipsy-w').tipsy({gravity: 'w',html: true});

  $('.delete_task').click(function(){
    var p = this.href
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
var unhold = function(e){
  $(this).val('');
}
var hold = function(e){
  if ($(this).val() == ''){
    $(this).val($(this).attr('data-placeholder'));
  }
}

