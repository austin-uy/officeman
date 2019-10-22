//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
$(function(){
  $('#close').click(function (event) {
    event.preventDefault()
    $("#test").trigger("reset")
  });

  $(document).ready(function(){
    let search = new URLSearchParams(document.location.search)
    if(search.get("open") !== null && search.get("open") === "true"){
      $('#addUser').modal('show');
    }
  })
  
  $(document).on("turbolinks:load",function(){
    $('[data-toggle="tooltip"]').tooltip()
  })
  
  $(".alert").fadeOut(3000);

  $('#editPassword').on('show.bs.modal', function (e) {
    $("#edit-password-alert").html("");
    $(".form-control.current").val("");
    $(".form-control.new").val("");
    $(".form-control.confirm").val("");
  })

  $(".edit_user").submit(function(e){
    e.preventDefault()
    $("#edit-password-alert").html("");
    $.ajax({
      url: '/update_password',
      type: 'PUT',
      data: {
        authenticity_token: $("#user_authenticity_token").val(),
        user:{
          id: $("#user_id").val(),
          current_password: $(".form-control.current").val(),
          password: $(".form-control.new").val(),
          password_confirmation: $(".form-control.confirm").val(),
        },
        noredirect: true
      },
      dataType: 'json',
      statusCode: {
        422: function(response) {
          $("#edit-password-alert").html("<div class='alert alert-danger fade show' role='alert'>"+response.responseJSON.messages.join('<br>')+"</div>");
          $('input[type="submit"]').removeAttr('disabled');
        },
        200: function(response){
          $("#edit-password-alert").html("<div class='alert alert-info fade show' role='alert'>Password Updated</div>");
        }
      }
    })
  })
})