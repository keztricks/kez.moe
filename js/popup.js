
$(document).ready(function() {
    $(".trigger-popup").click(function() {
        var popupId = $(this).data("popup-trigger");
        $("[data-popup='" + popupId +"']").removeClass('hidden');
        $("body").css("overflow", "hidden");
    });
    $(".close-popup").click(function() {
        $("body").css("overflow", "visible");
        $(".popup").addClass('hidden');
    });
});