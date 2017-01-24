$(document).ready ->
  # Handle changing up/down arrow on accordion
  $( ".toggle-form [data-toggle='collapse']" ).click ->
    $( this ).toggleClass('glyphicon-menu-up')