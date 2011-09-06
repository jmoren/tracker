// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $('.delete_task').click(function(){
    var p = $(this).attr('href')
    id = p.split('/')[2]
    $('#'+id).find('.task').html('<div><img src="/images/loading.gif"> eliminado...</div>')
  });  
});
