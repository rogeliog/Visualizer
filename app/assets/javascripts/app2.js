$(function () {
  var po = org.polymaps;
  var id = $('.tiles-map').attr('id');

  var map = po.map()
      .container(document.getElementsByClassName("tiles-map")[0].appendChild(po.svg("svg")))
      .center({lat: 25.67, lon: -100.30})
      .zoom(6)
      .zoomRange([5, 8])
      .add(po.interact());

  map.add(po.image()
      .url(po.url("/tiles/{Z}/{X}/{Y}.png")
      ));

  if (id) {
    map.add(po.geoJson()
        .url("/datasets/" + id + ".json?bbox={B}")
        .on("load", load)
        .clip(false)
        .zoom(6));
  }

  map.add(po.compass()
      .pan("none"));

  var setRadius = function(points) {
    $.each(points, function(index, point){
      console.log(point.feature);
      point.setAttribute("r", Math.ceil(Math.random()* 50));
    });
  };

  function load(e) {
    points = [];

    for (var i = 0; i < e.features.length; i++) {
      var f = e.features[i],
      c = f.element;
      g = f.element = po.svg("g");

      point = g.appendChild(po.svg("circle"));
      point.setAttribute("cx", 0);
      point.setAttribute("cy", 0);
      point.setAttribute("class", "point");
      point.feature = f;

      points.push(point);

      g.setAttribute("transform", c.getAttribute("transform"));
      g.setAttribute("style","cursor:pointer;");
      g.setAttribute("data-name", f.data.id);
      c.parentNode.replaceChild(g, c);
    }
    setRadius(points);
  };

  $('#config').on('change', 'input[type=radio]', function(){
    console.log($(this).val());
    setRadius( $('svg.map circle.point').toArray() );
  })
});
