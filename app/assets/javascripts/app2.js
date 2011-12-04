$(function () {

  var po = org.polymaps;

  var map = po.map()
      .container(document.getElementById("map").appendChild(po.svg("svg")))
      .center({lat: 25.67, lon: -100.30})
      .zoom(6)
      .zoomRange([5, 8])
      .add(po.interact());

  map.add(po.image()
      .url(po.url("/tiles/{Z}/{X}/{Y}.png")
      ));

  map.add(po.geoJson()
      .url("/json?bbox={B}")
      .on("load", load)
      .clip(false)
      .zoom(6));

  map.add(po.compass()
      .pan("none"));

  function load(e) {
    var tile = e.tile, g = tile.element;
    while (g.lastChild) g.removeChild(g.lastChild);

    if (e.features.length > 0) {
      console.log(e);
    }

    for (var i = 0; i < e.features.length; i++) {
      var data  = e.features[i].data;
      var point = g.appendChild(po.svg("circle"));
      var value = data.properties['Salud'];

      point.setAttribute("cx", data.geometry.coordinates[0]);
      point.setAttribute("cy", data.geometry.coordinates[1]);
      point.setAttribute("r", 5);
    }
  }

});
