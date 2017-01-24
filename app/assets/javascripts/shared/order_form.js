$(document).ready(function(){

    // Update the dropzone filename
    $("input:file").change(function(){
        var file = $(this)[0].files[0];

        if(file) {
            $(this).attr('title', file.name);
            $(this).siblings('.filename').text(file.name);
            $(this).siblings('.filesize').text(formatBytes(file.size, 1));
        }else{
            $(this).removeAttr('title');
            $(this).siblings('.filename').text('No file chosen');
            $(this).siblings('.filesize').text('');
        }
    });

    // When loading an existing form, make sure to format the Bytes
    $(".filesize").filter(function(){
        $(this).text(formatBytes($(this).data('filesize'), 1));
    });

});

function formatBytes(bytes,decimals) {
    if(bytes == 0) return '';
    var k = 1000; // or 1024 for binary
    var dm = decimals + 1 || 3;
    var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}