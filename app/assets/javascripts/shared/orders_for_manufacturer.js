$(document).ready(function(){

    // AJAX call to change order status to in progress
    $( ".set-status-btn").click(function(){
        var orderNumber = $(this).data('order-number');
        var status = $(this).data('status');
        
        $.ajax('change_order_status/' + orderNumber, {
            method: 'POST',
            data: {
                status: status
            }
        }).done(function(){
            location.reload();
        }).error(function(err){
            console.log(err);
        });
        
        return false;
    });

    // AJAX call to change order status to in progress
    $( ".set-tracking-btn").click(function(){
        var orderNumber = $(this).data('order-number');
        var trackingNumber = $(this).closest(".input-group").find("input").val();

        $.ajax({
            url: Spree.pathFor('change_order_manufacturer_tracking/' + orderNumber),
            method: 'POST',
            data: {
                tracking: trackingNumber
            }
        }).done(function(){
            location.reload();
        }).error(function(err){
            console.log(err);
        });

        return false;
    });

    $(".edit-tracking-btn").click(function(){
        $(this).closest("td").find(".tracking-number").toggleClass("hide");
        $(this).closest("td").find(".tracking").toggleClass("hide");
        
        return false;
    });
});
