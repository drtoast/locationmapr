// http://code.google.com/apis/maps/documentation/javascript/
// http://econym.org.uk/gmap/example_map12.htm

var initialLocation;
var siberia =           new google.maps.LatLng(60, 105);
var newyork =           new google.maps.LatLng(40.69847032728747, -73.9514422416687);
var sanfrancisco =      new google.maps.LatLng(37.762742,-122.401235);
var browserSupportFlag =  new Boolean();
var markers = [];

function initialize() {
  $(".datepicker").datepicker().change(function() {loadJson(map)});
  
  var map_options = {
    zoom: 10,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"), map_options);
  map.setCenter(sanfrancisco);
  addMarker(map,37.762742,-122.401235,"home");
  loadJson(map);
}


function loadJson(map) {
    deleteMarkers();
    var from = $("#from.datepicker")[0].value;
    var to = $("#to.datepicker")[0].value;
    if (from != "" && to != "") {
        var url = "/markers?from=" + encodeURIComponent(from) + "&to=" + encodeURIComponent(to); // "data/markers.json";
        $.getJSON(url,
            function(data){	
                  $.each(data.markers, function(i,markers) {
                      var mylat = Number(data.markers[i].lat);
                      var mylng = Number(data.markers[i].lng);
                      var mytitle = String(data.markers[i].time);
                      var myaccuracy = Number(data.markers[i].ha);
                      var myconfidence = Number(data.markers[i].conf);
                      // console.log("adding " + String(mylng));
                      addMarker(map,mylat,mylng,myaccuracy,mytitle);
                    });
                });
    }
}

function addMarker(map,lat,lng,accuracy,title) {
    var icon;
    if (accuracy <= 500) {
        icon = 'images/dot_red_50.png';
    } else {
        icon = 'images/dot_blue_50.png';
    }
    var myLatlng = new google.maps.LatLng(lat,lng);
    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        icon: icon,
        title: title
    });
    markers.push(marker);
}

function deleteMarkers() {
  if (markers) {
    for (i in markers) {
      markers[i].setMap(null);
    }
    markers.length = 0
  }
}