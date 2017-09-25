
$(document).ready(function() {

    $("#trigger-popup").click(function() {
        $(".popup").removeClass('hidden');
    });
    $("#close-popup").click(function() {
        $(".popup").addClass('hidden');
    });
});
