$(function(){
  $(document).ready(function(){
    let search = new URLSearchParams(document.location.search)
    if(search.get("open") !== null && search.get("open") === "true"){
      $('#addEquipment').modal('show');
    }
  })
  $('[data-toggle="tooltip"]').tooltip()
})