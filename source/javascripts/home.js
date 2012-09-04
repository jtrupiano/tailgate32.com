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
      loadVideo(Episodes[index].video_id, index);
    });
  });
  loadVideo(Episodes[0].video_id, 0);

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

var Episodes = [
  { number: "Tailgate32", title: "The Trailer", date: "August 15th, 2012", video_id: "q3eWWvPwXEA" },
];

var Upcoming = [
  { title: "GAME 1: Dallas @ New York", city: "New York", date: "September 5th, 2012" },
  { title: "GAME 2: Philadelphia @ Cleveland", city: "Cleveland", date: "September 9th, 2012" },
  { title: "GAME 3: Cincinnati @ Baltimore", city: "Baltimore", date: "September 10th, 2012" },
  { title: "GAME 4: Chicago @ Green Bay", city: "Green Bay", date: "September 13th, 2012" }
];

function loadVideo(id, index) {
  unselectAll();
  $($('#recent-episodes .recent-episode')[index]).css("background", "url('images/recent-arrow-selected.png') no-repeat");
  $('#episode-highlight').show();

  $('#ytplayer').attr('src', 'http://www.youtube.com/embed/' + id + '?vq=hd720&rel=0&showinfo=0&autoplay=1');
  $('#home-chrome h2').text(Episodes[index].number + ": " + Episodes[index].title);

}

function loadUpcoming(game, index) {
  unselectAll();
  $($('#upcoming-episodes .upcoming-episode')[index]).css("background", "url('images/upcoming-arrow-selected.png') no-repeat");
  $('#upcoming-highlight').show();

  $('#upcoming-game-title').text(game.title);
}

function unselectAll() {
  $('#ytplayer').attr('src', '');
  $('#upcoming-highlight').hide();
  $('#episode-highlight').hide();
  $('#recent-episodes .recent-episode').css("background", "url('images/recent-arrow.png') no-repeat");
  $('#upcoming-episodes .upcoming-episode').css("background", "url('images/upcoming-arrow.png') no-repeat");
}
