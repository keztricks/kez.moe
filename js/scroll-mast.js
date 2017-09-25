$(document).ready(function() {

  $(window).scroll(function () {
      //if you hard code, then use console
      //.log to determine when you want the
      //nav bar to stick.
     console.log($(window).scrollTop())
    if ($(window).scrollTop() > 150) {
      $('#mast').addClass('masthead-fixed');
      $('#mast').addClass('shadow');
    }
    if ($(window).scrollTop() < 151) {
      $('#mast').removeClass('masthead-fixed');
      $('#mast').removeClass('shadow');
    }
    if ($(window).scrollTop() > 70) {
      $('#main-head').addClass('hidden');
      $('#sec-head').removeClass('hidden');
    }
    if ($(window).scrollTop() < 71) {
      $('#main-head').removeClass('hidden');
      $('#sec-head').addClass('hidden');
    }
  });
});
