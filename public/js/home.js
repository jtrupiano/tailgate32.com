$().ready(function() {
  // Set up rollover for call to action
  $('#call-to-action-link').hover(function() {
    $('#call-to-action-shirt').attr("src", "images/shirt-hover.png");
    $('#call-to-action-kickstart').attr("src", "images/kickstart-hover.png");
  }, function() {
    $('#call-to-action-shirt').attr("src", "images/shirt.png");
    $('#call-to-action-kickstart').attr("src", "images/kickstart.png");
  });

  // set fancybox defaults
  $.fancybox.defaults.beforeLoad = function() { $('#video-container').css('visibility', 'hidden'); };
  $.fancybox.defaults.afterClose = function() { $('#video-container').css('visibility', 'visible'); };
});

