
$(document).ready(function() {

    $("#trigger-popup").click(function() {
        var popupId = $(this).data("popup-trigger");
        $("[data-popup='" + popupId +"']").removeClass('hidden');
    });
    $("#close-popup").click(function() {
        $(".popup").addClass('hidden');
    });
});
