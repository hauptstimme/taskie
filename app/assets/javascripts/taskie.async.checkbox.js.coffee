$(document).ready ->
  $("#main-content").on "change", "form[id^=edit_task].status-toggle", ->
    $("#spinner").show("fast").css display: "inline-block"
    $(this).submit()
