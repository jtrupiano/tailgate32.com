$().ready(function() {
  // set fancybox defaults
  $.fancybox.defaults.beforeLoad = function() { $('#video-container').css('visibility', 'hidden'); };
  $.fancybox.defaults.afterClose = function() { $('#video-container').css('visibility', 'visible'); };

  // Load up the episodes
  $.each(Episodes, function(index, ep) {
    var ep_elem = $($('#recent-episodes .recent-episode')[index]);
    ep_elem.find('a').click(function() {
      loadVideo(Episodes[index], index);
    });
  });
  loadVideo(Episodes[0], 0); 

  // Load up the upcoming games
  $.each(Upcoming, function(index, game) {
    var game_elem = $($('#upcoming-episodes .upcoming-episode')[index]);
    game_elem.find('a').click(function() {
      loadUpcoming(Upcoming[index], index);
    });
  });
});

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
  $('#upcoming-game-description').html(game.description);
}

function unselectAll() {
  $('#ytplayer').attr('src', '');
  $('#upcoming-highlight').hide();
  $('#episode-highlight').hide();
  $('#recent-episodes .recent-episode').css("background", "url('images/recent-arrow.png') no-repeat");
  $('#upcoming-episodes .upcoming-episode').css("background", "url('images/upcoming-arrow.png') no-repeat");
}
