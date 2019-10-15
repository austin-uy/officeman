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
  
  $(".alert").fadeOut(3000);

  $('[data-toggle="tooltip"]').tooltip()
})