$(document).ready(function() {
    $('#text').focus();
    $('#text').prop('disabled', true);
    $('#talk').prop('disabled', true);

    $('#text').keyup(function(event) {
        if(event.keyCode == 13) {
            $("#talk").click();
        }
    });
})