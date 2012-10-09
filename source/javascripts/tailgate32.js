$().ready(function() {
  // Set up contact us fancybox
  $('a.contact-us-link').click(function() {
    // clear the form
    $('#contact-us-form input[type="text"], #contact-us-form textarea').val("");
    $('#contact-us-form').show();
    $('#contactu-us-thanks').hide();
    $.fancybox.open($('#contact-us'));
  });
  
  // Set the action after load (to prevent spam)
  $('#contact-us-form').attr('action', 'https://docs.google.com/spreadsheet/formResponse?formkey=dEY2MXNvVDRBWlN1SEE0RHRyQU42d3c6MQ&ifq');

  // Set up contact us form AJAX
  $('#contact-us-submit').click(function() {
    $('#contact-us-form').fadeOut('slow');
    $('#contact-us-thanks').fadeIn('slow');
  });
});
