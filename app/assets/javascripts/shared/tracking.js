$(document).ready(function(){

    // AJAX call to track package
    $( ".tracking-number a").click(function(){
        var number = $(this).text();
        
        $.ajax({
            url: Spree.pathFor('track_package/' + number)
        }).done(function(response){
            //console.log(response);
            var content = '';

            var trackInfo = response.TrackResponse.TrackInfo;

            if(trackInfo.Error){
                content = '<div class="alert alert-danger"><strong>Error! </strong>' + trackInfo.Error.Description + '</div>';
            }else{
                var trackDetails = trackInfo.TrackDetail;
                var trackSummary = trackInfo.TrackSummary;

                var summary = '<div class="alert alert-success"><i class="glyphicon glyphicon-ok-circle text-success"></i> Your package has been <strong>Delivered</strong></div>'

                var table = '<table class="table table-striped">';

                table += '<tr><th>Event</th><th>Location</th></tr>';

                trackDetails.forEach(function(detail){
                    table += '<tr>';
                    table += '<td>' + detail.Event + '<br><small>' + detail.EventDate + ' at ' + detail.EventTime + '</small></td>';
                    table += '<td>';

                    if(detail.EventCity != null)
                        table += detail.EventCity + ' ';
                    if(detail.EventState != null)
                        table += detail.EventState + ' ';
                    if(detail.EventCountry != null)
                        table += detail.EventCountry;

                    table +='</td>';
                    table += '</tr>'
                });

                table += '</table>';

                if(trackSummary.Event == 'Delivered'){
                    content = summary + table;
                }else{
                    content = table
                }
            }

            $('#trackingModal .modal-title').text('Tracking ' + number);
            $('#trackingModal .modal-body').html(content);

            $('#trackingModal').modal('show');
        }).error(function(err){
            console.log(err);
        });

        return false;
    });

    
});
