$(document).ready ->
  $("#main-content").on "change", "form[id^=edit_task].status-toggle", ->
    $("#loader").show()
    $(this).submit()
