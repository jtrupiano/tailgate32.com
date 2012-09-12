$().ready(function() {
  function buildEpisodeThumbnail(episode, index) {
    return "<div class='item'><a href='#featured-video'><img src='http://img.youtube.com/vi/" + episode.video_id + "/maxresdefault.jpg' /></a><h3>" + episode.number + ": " + episode.title + "</h3><span class='description'>" + episode.date + "</span></div>";
  }

  $.each(Episodes, function(index, episode) {
    $('#all-videos').append(buildEpisodeThumbnail(episode));
    $($('#all-videos .item')[index]).click(function() {
      Play.loadEpisode(Episodes[index]);
    });
  });
  $('#all-videos').append("<br />");
  Play.loadEpisode(Episodes[0]);
});

var Play = {
  loadEpisode: function(episode) {
    $('#featured-video h1').text(episode.number + ': ' + episode.title);
    $('#ytplayer').attr('src', 'http://www.youtube.com/embed/' + episode.video_id + '?vq=hd720&rel=0&showinfo=0');
    $('#social-media').html('<div class="fb-like" data-href="http://tailgate32.com/play.html?episode=' + episode.episode_number + '" data-send="true" data-width="550" data-show-faces="false" data-color-scheme="dark"></div>');
    FB.XFBML.parse();
  }
}
;