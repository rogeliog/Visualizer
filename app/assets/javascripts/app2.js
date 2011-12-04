$(function () {
  var po = org.polymaps;
  var id = $('.tiles-map').attr('id');
  var ranges;

  var map = po.map()
      .container(document.getElementsByClassName("tiles-map")[0].appendChild(po.svg("svg")))
      .center({lat: 23.0, lon: -102.2})
      .zoom(window.datasetZoom)
      .zoomRange([4, 6])
      .add(po.interact());

  map.add(po.image()
      .url(po.url("/tiles/{Z}/{X}/{Y}.png")
      ));

  if (id) {
    map.add(po.geoJson()
        .url("/datasets/" + id + ".json?bbox={B}")
        .on("load", load)
        .clip(false)
        );
  }

  map.add(po.compass()
      .pan("none"));

  var setRadius = function(points, name) {
    window.datasetProperty = name;
    $.each(points, function(index, point){
      var val    = point.feature.properties[name];
      var ranges = window.datasetRanges[name];
      var r = val / ranges[1] * window.datasetScale;

      if (!isNaN(r)) {
        point.setAttribute("r", r);
      };
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
      point.feature = f.data;

      points.push(point);

      g.setAttribute("transform", c.getAttribute("transform"));
      g.setAttribute("style","cursor:pointer;");
      g.setAttribute("data-name", f.data.id);
      c.parentNode.replaceChild(g, c);
    }
    setRadius(points, window.datasetDefaultColumn);
  };

  $('#config').on('change', 'input[type=radio]', function(){
    setRadius( $('svg.map circle.point').toArray(), $(this).val());
    $('footer em').html("(Mostrando " + $(this).val() + ")");
  })

  $('input#scale').change(function(){
    window.datasetScale = $(this).val();
    setRadius( $('svg.map circle.point').toArray(), window.datasetProperty);
  });
});
