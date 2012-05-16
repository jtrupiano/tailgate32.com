$().ready(function() {
  // set fancybox defaults
  $.fancybox.defaults.beforeLoad = function() { $('#video-container').css('visibility', 'hidden'); };
  $.fancybox.defaults.afterClose = function() { $('#video-container').css('visibility', 'visible'); };
  
  // Set up tshirt viewer fancybox
  $('#call-to-action a.tshirt-viewer').click(function() {
    $.fancybox.open($('#tshirt-viewer'));
    $('#tshirt-options').focus();
  });

  // Build tshirt viewer options
  var teams = {
    arizona: "Arizona Cardinals",
    atlanta: "Atlanta Falcons",
    baltimore: "Baltimore Ravens",
    buffalo: "Buffalo Bills",
    carolina: "Carolina Panthers",
    chicago: "Chicago Bears",
    cincinnati: "Cincinnati Bengals",
    cleveland: "Cleveland Browns",
    dallas: "Dallas Cowboys",
    denver: "Denver Cowboys",
    detroit: "Detroit Lions",
    greenbay: "Green Bay Packers",
    houston: "Houston Texans",
    indianapolis: "Indianapolis Colts",
    jacksonville: "Jacksonville Jaguars",
    kansascity: "Kansas City Chiefs",
    miami: "Miami Dolphins",
    minnesota: "Minnesota Vikings",
    newengland: "New England Patriots",
    neworleans: "New Orleans Saints",
    newyorkgiants: "New York Giants",
    newyorkjets: "New York Jets",
    oakland: "Oakland Raiders",
    philadelphia: "Philadelphia Eagles",
    pittsburgh: "Pittsburgh Steelers",
    sandiego: "San Diego Chargers",
    sanfrancisco: "San Francisco 49ers",
    seattle: "Seattle Seahawks",
    stlouis: "St. Louis Rams",
    tampabay: "Tampa Bay Buccaneers",
    tennessee: "Tennessee Titans",
    washington: "Washington Redskins"
  };

  $.each(teams, function(key, name) {
    $('#tshirt-options').append($("<option/>", {
      value: key,
      text: name,
      // Preselect Arizona
      selected: (key == "arizona")
    }));
  });

  // Attach event handler to select box
  $('#tshirt-options').change(function() {
    $('#tshirt-front').attr("src", "images/tshirts/" + $(this).val() + "-front.png");
    $('#tshirt-back').attr("src", "images/tshirts/" + $(this).val() + "-back.png");
  });

  // Set up contact us fancybox
  $('#contact-us-nav').click(function() {
    $.fancybox.open($('#contact-us'));
  });

  // Set up contact us form AJAX
  $('#contact-us-submit').click(function() {
    $('#contact-us-form').fadeOut('slow');
    $('#contact-us-thanks').fadeIn('slow');
  });
});
