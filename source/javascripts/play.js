var Play = {
  loadEpisode: function(episode) {
    $('#featured-video h1').text(episode.number + ': ' + episode.title);
    $('#ytplayer').attr('src', 'http://www.youtube.com/embed/' + episode.video_id + '?vq=hd720&rel=0&showinfo=0');
    $('#social-media').html('<div class="fb-like" data-href="http://tailgate32.com/play?episode=' + episode.abbreviation + '" data-send="true" data-width="550" data-show-faces="false" data-color-scheme="dark"></div>');
    FB.XFBML.parse();
  },

  loadFirstEpisode: function(city_abbr) {
    var episode_to_preload = Episodes[0];
    $.each(Episodes, function(index, episode) {
      if (episode.abbreviation == city_abbr) {
        episode_to_preload = episode;
      }
    });
    Play.loadEpisode(episode_to_preload);
  }
};

$().ready(function() {
  $.each(Episodes, function(index, episode) {
    $($('#all-videos .item')[index]).click(function() {
      Play.loadEpisode(Episodes[index]);
    });
  });
});
