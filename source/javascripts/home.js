$().ready(function() {
  // set fancybox defaults
  $.fancybox.defaults.beforeLoad = function() { $('#video-container').css('visibility', 'hidden'); };
  $.fancybox.defaults.afterClose = function() { $('#video-container').css('visibility', 'visible'); };
});
