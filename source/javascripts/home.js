$().ready(function() {
  $('#schedule-callout').click(function() {
    $.fancybox.open($('#schedule-popup'));
  });

  $('#schedule-contact-link').click(function() {
    $.fancybox.open($('#contact-us'));
  });
});
