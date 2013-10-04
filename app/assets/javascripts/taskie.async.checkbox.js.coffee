$(document).ready ->
  $("#main-content").on "change", "form[id^=edit_task]", ->
    $("#loader").show()
    $(this).submit()
