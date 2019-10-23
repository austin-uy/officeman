//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
var email_ok = true
var password_ok = true
var password_confirm_ok = true

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

  $('.custom-file-input').on('change',function(){
    var fileName = $(this).val().split('\\')[$(this).val().split('\\').length - 1];
    if(fileName === "") fileName = "Choose Image (jpeg/png format only)"
    $(this).next('.custom-file-label').html(fileName);
})

  $(".new_user #user_email").on('input',function() {
    $(".new_user #emailHelp").html("");
  })

  $('.new_user #user_email').blur(async function(){
    if(this.value !== ""){
      await $.ajax({
        url: '/validate_email',
        type: 'PUT',
        data: { 
          email: this.value,
          id: $(".new_user #user_id").val(),
          authenticity_token: $('.new_user input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(response.exists){
          $(".new_user #emailHelp").html("Email is already taken.");
          $('.new_user input[type="submit"]').prop('disabled', true);
        }else{
          window.email_ok = true;
        }
      })
    }else{
      window.email_ok = true;
    }

    if(window.email_ok && window.password_ok){
      $('.new_user input[type="submit"]').prop('disabled', false);
    }
  })

  $(".new_user #user_password_confirmation").on('input',function() {
    $(".new_user #confirmPasswordHelp").html("");
  })

  $('.new_user #user_password_confirmation').blur(function(){
    if($(".new_user #user_password").val() !== ""){
      if($(".new_user #user_password").val() === this.value){
        window.password_confirm_ok = true;
      }else{
        $(".new_user #confirmPasswordHelp").html("Password and Password confirmation doesn't match.");
        $('.new_user input[type="submit"]').prop('disabled', true);
        window.password_confirm_ok = false;
      }
    }else{
      window.password_confirm_ok = true;
    }

    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('.new_user input[type="submit"]').prop('disabled', false);
    }
  })


  $(".new_user").bind('ajax:complete', function(response) {
    if(response.originalEvent.detail[0].status === 200){
      $('.new_user').find("input[type=text], input[type=password]").val("");
      $(".new_user #profile_form_alert").html("<div class='alert alert-info fade show' role='alert'>Add successful.</div>")
    }else{
      $(".new_user #profile_form_alert").html("<div class='alert alert-danger fade show' role='alert'>Add error.</div>")
    }
  });

  $(".edit_user #user_email").on('input',function() {
    $(".edit_user #emailHelp").html("");
  })

  $('.edit_user #user_email').blur(async function(){
    if(this.value !== ""){
      await $.ajax({
        url: '/validate_email',
        type: 'PUT',
        data: { 
          email: this.value,
          id: $(".edit_user #user_id").val(),
          authenticity_token: $('.edit_user input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(response.exists){
          $(".edit_user #emailHelp").html("Email is already taken.");
          $('.edit_user input[type="submit"]').prop('disabled', true);
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

  $(".edit_user #user_current_password").on('input',function() {
    $(".edit_user #currentPasswordHelp").html("");
  })

  $('.edit_user #user_current_password').blur(async function(){
    if(this.value !== ""){
      await $.ajax({
        url: '/validate_password',
        type: 'PUT',
        data: { 
          password: this.value,
          id: $(".edit_user #user_id").val(),
          authenticity_token: $('.edit_user input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(!response.validate){
          $(".edit_user #currentPasswordHelp").html("Current Password incorrect.");
          $('.edit_user input[type="submit"]').prop('disabled', true);
          window.password_ok = false;
        }else{
          window.password_ok = true;
        }
      })
    }else{
      window.password_ok = true;
    }
    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('.edit_user  input[type="submit"]').prop('disabled', false);
    }
  })

  $(".edit_user  #user_email").on('input',function() {
    $(".edit_user  #emailHelp").html("");
  })

  $('.edit_user  #user_email').blur(async function(){
    if(this.value !== ""){
      await $.ajax({
        url: '/validate_email',
        type: 'PUT',
        data: { 
          email: this.value,
          id: $(".edit_user  #user_id").val(),
          authenticity_token: $('.edit_user  input[name="authenticity_token"]').val()
        },
        dataType: 'json'
      }).always(function(response){
        if(response.exists){
          $(".edit_user  #emailHelp").html("Email is already taken.");
          $('.edit_user  input[type="submit"]').prop('disabled', true);
          window.email_ok = false;
        }else{
          window.email_ok = true;
        }
      })
    }else{
      window.email_ok = true;
    }
    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('.edit_user input[type="submit"]').prop('disabled', false);
    }
  })

  $(".edit_user #user_password_confirmation").on('input',function() {
    $(".edit_user #confirmPasswordHelp").html("");
  })

  $('.edit_user #user_password_confirmation').blur(function(){
    if($(".edit_user #user_password").val() !== ""){
      if($(".edit_user #user_password").val() === this.value){
        window.password_confirm_ok = true;
      }else{
        $(".edit_user #confirmPasswordHelp").html("Password and Password confirmation doesn't match.");
        $('.edit_user input[type="submit"]').prop('disabled', true);
        window.password_confirm_ok = false;
      }
    }else{
      window.password_confirm_ok = true;
    }

    if(window.email_ok && window.password_ok && window.password_confirm_ok){
      $('.edit_user input[type="submit"]').prop('disabled', false);
    }
  })


  $(".edit_user").bind('ajax:complete', function(response) {
    if(response.originalEvent.detail[0].status === 200){
      $(".edit_user").find("input[type=text], input[type=password]").val("");
      $(".edit_user #profile_form_alert").html("<div class='alert alert-info fade show' role='alert'>Update successful.</div>")
    }else{
      $(".edit_user #profile_form_alert").html("<div class='alert alert-danger fade show' role='alert'>Update error.</div>")
    }
  });

})