//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
var email_ok = true
var password_ok = true
var password_confirm_ok = true
var submit_success = false

$(document).ready(function(){
  let search = new URLSearchParams(document.location.search)
  if(search.get("open") !== null && search.get("open") === "true"){
    $('#addUser').modal('show');
    $('#addQuestion').modal('show');
    $('#addEquipment').modal('show');
  }

})

$(document).on("turbolinks:load ready",function(){
  $(".alert").fadeOut(4000);

  $('[data-toggle="tooltip"]').tooltip()

  $('.custom-file-input').on('change',function(){
    var fileName = $(this).val().split('\\')[$(this).val().split('\\').length - 1];
    if(fileName === "") fileName = "Choose Image (jpeg/png format only)"
    $(this).next('.custom-file-label').html(fileName);
  })

  $("#editUser,#editProfile,#addUser").on('show.bs.modal',function(){

    //ALL
    let submit = $(this).find("input[type='submit']");
    let id = $(this).find("#user_id").val();
    let authenticity_token = $(this).find("#user_authenticity_token").val();
    let fields = $(this).find("form").find("input[type=text], input[type=password], input[type=email], input[type=file], select");
    let profileFormAlert = $(this).find("#profile_form_alert");
    profileFormAlert.val("")
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
          url: '/validate',
          type: 'PUT',
          data: { 
            email: this.value,
            id: id,
            authenticity_token: authenticity_token,
            type: "email"
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
        }
      })
  
      $(this).find("#user_current_password").blur(function(){
        if(this.value !== ""){
          $.ajax({
            url: '/validate',
            type: 'PUT',
            data: { 
              password: this.value,
              id: id,
              authenticity_token: authenticity_token,
              type: "password"
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
              newPasswordField.prop('disabled', false);
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
      }
    })

    $(this).find("#user_password").blur(function(){
      
      if(this.value === ""){
        passwordConfirmField.prop('disabled', true);
        passwordConfirmField.val("");
        confirmPasswordHelp.html("");
      }else if($(this.parentElement.parentElement).find('#user_password_confirmation').val() !== ""){
        if($(this.parentElement.parentElement).find('#user_password_confirmation').val() === this.value){
          window.password_confirm_ok = true;
          confirmPasswordHelp.html("");
        }
        else{
          confirmPasswordHelp.html("Password and Password confirmation doesn't match.");
          window.password_confirm_ok = false;
        }
      }else{
        passwordConfirmField.prop('disabled', false);
        window.password_confirm_ok = true;
      }
  
      if(window.email_ok && window.password_ok && window.password_confirm_ok){
        submit.prop('disabled', false);
      }else{
        submit.prop('disabled', true);
      }
    })

    $(this).find("#user_password_confirmation").on('input',function() {
      confirmPasswordHelp.html("");
    })

    $(this).find("#user_password_confirmation").blur(function(){
      
      if(this.value === ""){
        confirmPasswordHelp.html("");
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

    $(this).find('.new_user,.edit_user').bind('ajax:complete', function(response) {
      let formType = ""
      if(this.className === "new_user"){
        formType = "Create";
      }else{
        formType = "Update"
      }

      if(response.originalEvent.detail[0].status === 200){ 
        fields.prop('disabled',true);
        setTimeout(() => {
          submit.prop('disabled',true);
        }, 0);
        window.submit_success = true;
        profileFormAlert.html("<div class='alert alert-info fade show' role='alert'>"+formType+" successful.</div>")
      }else{
        profileFormAlert.html("<div class='alert alert-danger fade show' role='alert'>"+formType+" error.</div>")
      }
    });

  });


  $("#editUser,#editProfile,#addUser").on('hide.bs.modal',function(){
    let fields = $(this).find("form").find("input")
    fields.prop('disabled',false);
    $(this).find("#profile_form_alert").val("");
    if(window.submit_success){
      window.submit_success = false;
      location.reload();
    }
  });
  
  $('form').on('keypress', e => {
    if (e.keyCode == 13) {
        return false;
    }
  });

})