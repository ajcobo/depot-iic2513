# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//#START_HIGHLIGHT
$ -> 
  $('.store .entry > img').click ->
    $(this).parent().find(':submit').click()
//#END_HIGHLIGHT

$ ->
  $('.entry .add_to_cart').click (e) ->
    # Previene el comportamiento por default del boton (hacer submit)
    e.preventDefault()

    # Debemos hacer una llamada ajax con la información necesaria
    # Tenemos la URL, solo basta utilizarla
    url = $(this).closest('form').attr('action')
    url = url.replace(/\?/g, '.js?')
    jq_add = $.ajax ({
      url: url,
      method: 'POST'
    })
    jq_add.done (data) ->
      console.log('Cart updated')
    jq_add.fail (data) ->
      console.log('Cart not updated')

updateCart = (data) ->
  if $('#cart tr').length is 1 then $('#cart').show('blind', 1000)
  jq_product = $.ajax ({
    url: 'products/' + data.product_id + '.json'
  })
  jq_product.done (product_data) ->
    row = $( document.createElement('tr') )
    total_price = Number(data.price) * Number(data.quantity)
    row.append($('<td>' + data.quantity + '&times;</td>'))
    row.append($('<td>' + product_data.title + '</td>'))
    row.append($('<td class="item_price">' + formatMoney(total_price) + '</td>'))
    $('.total_line').before(row)
    row.css({'background-color':'#88ff88'})
       .animate({'background-color':'#114411'}, 1000);


