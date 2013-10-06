//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require bootstrap

$(document).ready(function(){
  document.addEventListener("page:fetch", function(){
    $("#loader").show();
  });
  document.addEventListener("page:receive", function(){
    $("#loader").hide();
  });
});
