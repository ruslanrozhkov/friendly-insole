$(document).ready ->
    $('.print-shipping-label-btn').click ->
      iframeId = $(this).siblings('iframe').attr('id')

      PDF = document.getElementById(iframeId)
      PDF.focus()
      PDF.contentWindow.print()

      return false