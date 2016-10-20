$(document).ready(function(){
  $("*[id^='edit-reply-btn-']").each(function(){
    var reply_id = $(this).attr('reply-id');
    $(this).click(function(){
      $("#edit-reply-" + reply_id).toggle();
      $("#reply-content-" + reply_id).toggle();
    })
  })
})
