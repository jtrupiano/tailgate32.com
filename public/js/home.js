function getParameterByName(name) {
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null) {
    return "";
  } else {
    return decodeURIComponent(results[1].replace(/\+/g, " "));
  }
}

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

  // Open tshirt dropdown if querystring is set
  var preselect = getParameterByName("team");
  if (preselect != "") {
    $('#tshirt-options').val(preselect).trigger("change");
    $.fancybox.open($('#tshirt-viewer'));
  }
});


