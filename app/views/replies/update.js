$("#edit-reply-<%= @reply.id %>").toggle();
$("#reply-content-<%= @reply.id %>").toggle();
$("#reply-content-<%= @reply.id %>").html('<%= @reply.content %>')
