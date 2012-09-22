$().ready(function() {
  // Set up contact us fancybox
  $('a.contact-us-link').click(function() {
    // clear the form
    $('#contact-us-form input[type="text"], #contact-us-form textarea').val("");
    $('#contact-us-form').show();
    $('#contactu-us-thanks').hide();
    $.fancybox.open($('#contact-us'));
  });

  // Set up contact us form AJAX
  $('#contact-us-submit').click(function() {
    $('#contact-us-form').fadeOut('slow');
    $('#contact-us-thanks').fadeIn('slow');
  });
});
