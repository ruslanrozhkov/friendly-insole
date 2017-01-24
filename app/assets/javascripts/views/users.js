$(document).ready(function(){

    // Submit the form for setting the default address
    $( "input[name='user[bill_address_id]'], input[name='user[ship_address_id]']" ).change(function() {
        $( this ).closest('form').submit();
    });

});
