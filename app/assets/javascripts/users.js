//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
let email_ok = true
let password_ok = true
let password_confirm_ok = true

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
    $('input[type="submit"]').removeAttr('disabled');
  })

  $("#user_email").on('input',function() {
    $("#emailHelp").html("");
  })

  $('#user_email').blur(function(){
    if(this.value !== ""){
      $.ajax({
        url: '/validate_email',
        type: 'PUT',
        data: { 
          email: this.value,
          id: $("#user_id").val(),
          authenticity_token: $('input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(response.exists){
          $("#emailHelp").html("Email is already taken.");
          $('input[type="submit"]').prop('disabled', true);
        }else{
          window.email_ok = true;
        }
      })
    }else{
      window.email_ok = true;
    }

    if(window.email_ok && window.password_ok){
      $('input[type="submit"]').prop('disabled', false);
    }
  })

  $("#user_current_password").on('input',function() {
    $("#currentPasswordHelp").html("");
  })

  $('#user_current_password').blur(function(){
    if(this.value !== ""){
      $.ajax({
        url: '/validate_password',
        type: 'PUT',
        data: { 
          password: this.value,
          id: $("#user_id").val(),
          authenticity_token: $('input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(!response.validate){
          $("#currentPasswordHelp").html("Current Password incorrect.");
          $('input[type="submit"]').prop('disabled', true);
          window.password_ok = false;
        }else{
          window.password_ok = true;
        }
      })
    }else{
      window.password_ok = true;
    }

    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('input[type="submit"]').prop('disabled', false);
    }
  })

  $("#user_email").on('input',function() {
    $("#emailHelp").html("");
  })

  $('#user_email').blur(function(){
    if(this.value !== ""){
      $.ajax({
        url: '/validate_email',
        type: 'PUT',
        data: { 
          email: this.value,
          id: $("#user_id").val(),
          authenticity_token: $('input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(response.exists){
          $("#emailHelp").html("Email is already taken.");
          $('input[type="submit"]').prop('disabled', true);
          window.email_ok = false;
        }else{
          window.email_ok = true;
        }
      })
    }else{
      window.email_ok = true;
    }

    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('input[type="submit"]').prop('disabled', false);
    }
  })

  $("#user_password_confirmation").on('input',function() {
    $("#confirmPasswordHelp").html("");
  })

  $('#user_password_confirmation').blur(function(){
    if($("#user_password").val() !== ""){
      if($("#user_password").val() === this.value){
        window.password_confirm_ok = true;
      }else{
        $("#confirmPasswordHelp").html("Password and Password confirmation doesn't match.");
        $('input[type="submit"]').prop('disabled', true);
        window.password_confirm_ok = false;
      }
    }else{
      window.password_confirm_ok = true;
    }

    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('input[type="submit"]').prop('disabled', false);
    }
  })

  // $(".edit_user").submit(function(e){
  //   $("#profile_form_alert").html("");
  //   debugger
  // })

  $(".edit_user").bind('ajax:complete', function() {
    console.log("HAHAHAHAAHHAHA")
  });

})