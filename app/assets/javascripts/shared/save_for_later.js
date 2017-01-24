$(document).ready(function(){

    // AJAX call to save line item for later
    $( ".save-for-later-btn").click(function(){
        var lineItemId = $(this).data('line-item');
        
        $.ajax({
            url: Spree.pathFor('save_for_later/' + lineItemId),
            method: 'POST'
        }).done(function(response){
            location = Spree.pathFor('cart');
        }).error(function(err){
            console.log(err);
        });

        return false;
    });

    // AJAX call to move saved line item to cart
    $( ".move-to-cart-btn").click(function(){
        var savedLineItemId = $(this).data('saved-line-item');

        $.ajax({
            url: Spree.pathFor('move_to_cart/' + savedLineItemId),
            method: 'POST'
        }).done(function(response){
            location = Spree.pathFor('cart');
        }).error(function(err){
            console.log(err);
        });

        return false;
    });
    
});
