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

  // Load up the episodes
  $.each(Episodes, function(index, ep) {
    var ep_elem = $($('#recent-episodes .recent-episode')[index]);
    ep_elem.find('.episode-number').text(Episodes[index].number);
    ep_elem.find('.episode-title').text(Episodes[index].title);
    ep_elem.find('.episode-date').text(Episodes[index].date);
    ep_elem.find('a').click(function() {
      loadVideo(Episodes[index], index);
    });
  });
  loadVideo(Episodes[0], 0);

  // Load up the upcoming games
  $.each(Upcoming, function(index, game) {
    var game_elem = $($('#upcoming-episodes .upcoming-episode')[index]);
    game_elem.find('.upcoming-city').text(Upcoming[index].city);
    game_elem.find('.upcoming-date').text(Upcoming[index].date);
    game_elem.find('a').attr("href", "javascript:void(0)");
    game_elem.find('a').click(function() {
      loadUpcoming(Upcoming[index], index);
    });
  });
});

var Upcoming = [
  { title: "GAME 4: Chicago @ Green Bay", city: "Green Bay", date: "September 13th, 2012" },
  { title: "GAME 5: Houston @ Jacksonville", city: "Jacksonville", date: "September 16th, 2012" },
  { title: "GAME 6: Denver @ Atlanta", city: "Atlanta", date: "September 17th, 2012" },
  { title: "GAME 7: New York @ Carolina", city: "Carolina", date: "September 20th, 2012" }
];

function loadVideo(episode, index) {
  unselectAll();
  $($('#recent-episodes .recent-episode')[index]).css("background", "url('images/recent-arrow-selected.png') no-repeat");
  $('#episode-highlight').show();

  $('#ytplayer').attr('src', 'http://www.youtube.com/embed/' + episode.video_id + '?vq=hd720&rel=0&showinfo=0');
  $('#home-chrome h2').text(episode.number + ": " + episode.title);
}

function loadUpcoming(game, index) {
  unselectAll();
  $($('#upcoming-episodes .upcoming-episode')[index]).css("background", "url('images/upcoming-arrow-selected.png') no-repeat");
  $('#upcoming-highlight').show();

  $('#upcoming-game-title').text(game.title);
  $('#upcoming-game-description').html($('#data' + index).html());
}

function unselectAll() {
  $('#ytplayer').attr('src', '');
  $('#upcoming-highlight').hide();
  $('#episode-highlight').hide();
  $('#recent-episodes .recent-episode').css("background", "url('images/recent-arrow.png') no-repeat");
  $('#upcoming-episodes .upcoming-episode').css("background", "url('images/upcoming-arrow.png') no-repeat");
}
;