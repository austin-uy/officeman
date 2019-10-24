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

})

$(document).on("turbolinks:load ready",function(){
  $('.custom-file-input').on('change',function(){
    var fileName = $(this).val().split('\\')[$(this).val().split('\\').length - 1];
    if(fileName === "") fileName = "Choose Image (jpeg/png format only)"
    $(this).next('.custom-file-label').html(fileName);
  })
  

  $('form[action="/users"] #user_email').on('input',function() {
    $(".new_user #emailHelp").html("");
  })

  $('form[action="/users"] #user_email').blur(async function(){
    if(this.value !== ""){
      await $.ajax({
        url: '/validate_email',
        type: 'PUT',
        data: { 
          email: this.value,
          id: $(".new_user #user_id").val(),
          authenticity_token: $('.new_user input[name="user[authenticity_token]"]').val()
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

  $('form[action="/users"] #user_password_confirmation').on('input',function() {
    $(".new_user #confirmPasswordHelp").html("");
  })

  $('form[action="/users"] #user_password_confirmation').blur(function(){
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

  $('form[action="/users"]').bind('ajax:complete', function(response) {
    if(response.originalEvent.detail[0].status === 200){
      $(".new_user").find("input[type=text], input[type=password]").val("");
      $(".new_user #profile_form_alert").html("<div class='alert alert-info fade show' role='alert'>Create successful.</div>")
    }else{
      $(".new_user #profile_form_alert").html("<div class='alert alert-danger fade show' role='alert'>Create error.</div>")
    }
  });

  $("#editUser,#editProfile").on('show.bs.modal',function(){

    //ALL
    let submit = $(this).find("input[type='submit']");
    let id = $(this).find("#user_id").val();
    let authenticity_token = $(this).find("#user_authenticity_token").val();
    let fields = $(this).find(".edit_user").find("input[type=text], input[type=password]");
    let profileFormAlert = $(this).find("#profile_form_alert");

    //EMAIL
    let emailHelp = $(this).find("#emailHelp");

    //NEW PASSWORD
    let newPasswordField = $(this).find("#user_password");

    //CONFIRM PASSWORD
    let confirmPasswordHelp = $(this).find("#confirmPasswordHelp");
    let passwordConfirmField = $(this).find("#user_password_confirmation");

    //CURRENT PASSWORD
    let currentPasswordField = $(this).find("#user_current_password");
    let currentPasswordHelp = $(this).find("#currentPasswordHelp");

    $(this).find("#user_email").on('input',function() {
      emailHelp.html("");
    })
 
    $(this).find("#user_email").blur(async function(){
      if(this.value !== ""){
        await $.ajax({
          url: '/validate_email',
          type: 'PUT',
          data: { 
            email: this.value,
            id: id,
            authenticity_token: authenticity_token
          },
          dataType: 'json'
        }).always(function(response){
          if(response.exists){
            emailHelp.html("Email is already taken.");
            window.email_ok = false;
          }else{
            window.email_ok = true;
          }
        })
      }else{
        window.email_ok = true;
      }
  
      if(window.email_ok && window.password_ok){
        submit.prop('disabled', false);
      }else{
        submit.prop('disabled', true);
      }
    })

    if(currentPasswordField.length > 0){
      $(this).find("#user_current_password").on('input',function() {
        currentPasswordHelp.html("");
        if(this.value===""){
          newPasswordField.prop('disabled', true);
          passwordConfirmField.prop('disabled', true);
          newPasswordField.val("");
          passwordConfirmField.val("");
          confirmPasswordHelp.html("");
          window.password_confirm_ok = true;
        }else{
          newPasswordField.prop('disabled', false);
        }
      })
  
      $(this).find("#user_current_password").blur(function(){
        if(this.value !== ""){
          $.ajax({
            url: '/validate_password',
            type: 'PUT',
            data: { 
              password: this.value,
              id: id,
              authenticity_token: authenticity_token
            },
            dataType: 'json'
          }).always(function(response){
            if(!response.validate){
              currentPasswordHelp.html("Current Password incorrect.");
              newPasswordField.prop('disabled', true);
              passwordConfirmField.prop('disabled', true);
              newPasswordField.val("");
              passwordConfirmField.val("");
              confirmPasswordHelp.html("");
              window.password_confirm_ok = false;
              window.password_ok = false;
            }else{
              window.password_ok = true;
              window.password_confirm_ok = false;
            }

          })
        }else{
          window.password_ok = true;
        }

        if(window.email_ok && window.password_ok && window.password_confirm_ok){
          submit.prop('disabled', false);
        }else{
          submit.prop('disabled', true);
        }
      })
    }

    $(this).find("#user_password").on('input',function() {
      if(this.value===""){
        passwordConfirmField.prop('disabled', true);
        passwordConfirmField.val("");
        confirmPasswordHelp.html("");
      }else{
        passwordConfirmField.prop('disabled', false);
      }
    })

    $(this).find("#user_password_confirmation").on('input',function() {
      confirmPasswordHelp.html("");
    })

    $(this).find("#user_password_confirmation").blur(function(){
      
      if(this.value === ""){
        confirmPasswordHelp.html("");
        window.password_confirm_ok = false;
      }else if($(this.parentElement.parentElement).find('#user_password').val() !== ""){
        if($(this.parentElement.parentElement).find('#user_password').val() === this.value){
          window.password_confirm_ok = true;
        }
        else{
          confirmPasswordHelp.html("Password and Password confirmation doesn't match.");
          window.password_confirm_ok = false;
        }
      }else{
        window.password_confirm_ok = true;
      }
  
      if(window.email_ok && window.password_ok && window.password_confirm_ok){
        submit.prop('disabled', false);
      }else{
        submit.prop('disabled', true);
      }
    })

    $(this).find(".edit_user").bind('ajax:complete', function(response) {
      if(response.originalEvent.detail[0].status === 200){
        fields.val("");
        profileFormAlert.html("<div class='alert alert-info fade show' role='alert'>Update successful.</div>")
      }else{
        profileFormAlert.html("<div class='alert alert-danger fade show' role='alert'>Update error.</div>")
      }
    });

  });
  
})