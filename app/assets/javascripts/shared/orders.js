$(document).ready(function(){

    // Handle changing up/down arrow on accordion
    $( "[data-toggle='collapse']" ).click(function(){
       $( this ).toggleClass('glyphicon-menu-up');
    });

    // Datepicker calendars
    $( "#q_completed_at_gt" ).datepicker({
        showOtherMonths: true,
        selectOtherMonths: true,
        dateFormat: 'yy/mm/dd',
        onClose: function( selectedDate ) {
            $( "#q_completed_at_lt" ).datepicker("option", "minDate", selectedDate );
        }
    });
    $( "#q_completed_at_lt" ).datepicker({
        showOtherMonths: true,
        selectOtherMonths: true,
        dateFormat: 'yy/mm/dd',
        onClose: function( selectedDate ) {
            $( "#q_completed_at_gt" ).datepicker( "option", "maxDate", selectedDate );
        }
    });

    //$( "#q_completed_at_lt" ).datepicker("option", "minDate", $( "#q_completed_at_gt" ).val() );
    //$( "#q_completed_at_gt" ).datepicker("option", "maxDate", $( "#q_completed_at_lt" ).val() );


    // AJAX call to cancel order
    $( ".cancel-order-btn").click(function(){
        var orderNumber = $( this ).data('order-number');

        $.ajax('orders/' + orderNumber + '/cancel',{
            method: 'DELETE'
        }).done(function(){
            location.reload();
        });
    });

    // AJAX call to duplicate order
    $(".duplicate-order").click(function(){
        var orderNumber = $( this ).data('order-number');

        $.ajax('duplicate_order/' + orderNumber, {
            method: 'POST'
        }).done(function(){
            window.location = 'cart';
        }).error(function(err){
            console.log(err);
        });

        return false;
    })
});
