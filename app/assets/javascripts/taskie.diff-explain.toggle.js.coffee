$(document).ready ->
  $(".activity #diff-explain-toggle").on "click", ->
    $(this).parents(".activity").find(".diff-explain").toggle "fast"
