$(document).ready(function(){

    // Open the correct messages panel in case we want to reply right away
    var hash = window.location.hash;
    if (hash == '#user' || hash == '#manufacturer') {
        //open the proper HQ message panel that we are replying to
        $('#messagesTabs a[href="' + hash + '"]').tab('show');

        //focus into the textbox
        $(hash + '_body').focus();
    }else if(hash == '#reply'){
        //bring the reply box into focus
        $('textarea').focus();
    }

    // Scroll to the bottom of the messaging window
    var $messagingContainer = $(".messaging .messages-container");
    $messagingContainer.each(function(index, messageContainer){
        $(messageContainer).scrollTop(messageContainer.scrollHeight);
    });


    // Dismiss the message when the X is clicked
    $('.message-dismiss').click(function(){
        var self = this;
        
        //Do AJAX call to mark message as read and then clean up the UI
        markAsRead(self, function(){
            cleanReadMessages(self);
        }, function(){
            location.reload()
        });

        return false;
    });

    $('.message-order-number, .message-reply').click(function(){
        var self = this;

        //Do AJAX call to mark message as read
        markAsRead(self, function(){
            // setTimeout(function(){
            //     cleanReadMessages(self);
            // }, 1000); //set this so that we dont see it disappear b4 we navigate away
        });
    });

});

function markAsRead(node, doneCb, errCb){
    messageId = $(node).closest('.message').data('id');

    $.ajax({
        url: Spree.pathFor('messages/' + messageId ),
        type: 'PUT',
        data:{
            message: {
                read: true
            }
        }
    }).done(function(){
        if (doneCb)
            doneCb();
    }).error(function(err){
        if (errCb)
            errCb();
    });
}

function cleanReadMessages(node){
    $(node).closest('.message').fadeOut(400, function(){
        $(node).closest('.message').remove();

        if(!$('.messages .message').length){
            $('.messages').append('<div class="alert alert-info"><strong>Hooray!</strong> You have no pending messages.</div>');
        }
    });
}