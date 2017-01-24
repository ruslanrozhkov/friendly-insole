$(document).ready ->
    # Take off the current function binding to the save button
    $('.line-items a.save-line-item').off()

    $(".line-items a.edit-line-item, .line-items a.cancel-line-item").click ->
        $(this).closest("tr").next().find(".order-form").toggleClass("read-only")

    $('.line-items a.save-line-item').click ->
        save = $ this
        line_item_id = save.data('line-item-id')
        quantity = parseInt(save.parents('tr').find('input.line_item_quantity').val())
        form = save.parents('tr').next().find('form')

        options = form.serializeFormJSON()

        data = new FormData()

        stl_file_l = $(form).find('input[name="options[stl_file_l]"]')[0].files[0]
        stl_file_r = $(form).find('input[name="options[stl_file_r]"]')[0].files[0]
        csv_file = $(form).find('input[name="options[csv_file]"]')[0].files[0]

        data.append('line_item[stl_file_l]', stl_file_l)
        data.append('line_item[stl_file_r]', stl_file_r)
        data.append('line_item[csv_file]', csv_file)
        data.append('line_item[quantity]', quantity)
        data.append('line_item[options]', JSON.stringify(options))
        data.append('token', Spree.api_key)

        updateLineItem(line_item_id, data)
        false


# Override the existing spree adjustLineItem function with updateLineItem
# so that we can now handle also saving the form
lineItemURL = (line_item_id) ->
    url = Spree.routes.orders_api + "/" + order_number + "/line_items/" + line_item_id + ".json"

updateLineItem = (line_item_id, data) ->
    url = lineItemURL(line_item_id)
    $.ajax(
      type: "PUT",
      url: Spree.url(url),
      contentType: false,
      processData: false,
      data: data
    ).done (msg) ->
      if msg.window
        window.location = msg.window
      else
        window.Spree.advanceOrder()

$.fn.serializeFormJSON = ->
  o = {}
  a = @serializeArray()
  $.each a, ->
    if o[@name]
      if !o[@name].push
        o[@name] = o[@name]
      #o[@name].push @value or ''
    else
      o[@name] = @value or ''
    return
  o
