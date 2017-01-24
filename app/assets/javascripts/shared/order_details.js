$(document).ready(function(){

    // AJAX call to duplicate line item
    $(".duplicate-item").click(function(){
        var itemId = $( this ).data('item-id');
        var url = Spree.pathFor('duplicate_item/' + itemId);

        $.ajax({
            url: url,
            method: 'POST'
        }).done(function(){
            window.location = Spree.pathFor('cart');
        }).error(function(err){
            console.log(err);
        });

        return false;
    })

});