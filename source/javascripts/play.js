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
  function firstEpisodeToPlay() {
    var preload = getParameterByName("episode");
    var episode_to_preload = Episodes[0];
    $.each(Episodes, function(index, episode) {
      if (episode.abbreviation == preload) {
        episode_to_preload = episode;
      }
    });
    return episode_to_preload;
  }

  $.each(Episodes, function(index, episode) {
    $($('#all-videos .item')[index]).click(function() {
      Play.loadEpisode(Episodes[index]);
    });
  });
  Play.loadEpisode(firstEpisodeToPlay());
});

var Play = {
  loadEpisode: function(episode) {
    $('#featured-video h1').text(episode.number + ': ' + episode.title);
    $('#ytplayer').attr('src', 'http://www.youtube.com/embed/' + episode.video_id + '?vq=hd720&rel=0&showinfo=0');
    $('#social-media').html('<div class="fb-like" data-href="http://tailgate32.com/play?episode=' + episode.abbreviation + '" data-send="true" data-width="550" data-show-faces="false" data-color-scheme="dark"></div>');
    FB.XFBML.parse();
  }
}
