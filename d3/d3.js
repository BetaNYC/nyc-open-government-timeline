var width = 500,
    height = 500;


var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

d3.csv("Timeline.csv", function(csv) {
  
  var update = svg.selectAll("circle").data(csv)
  
  var linearScale = d3.scale.linear()
      .domain([0, 85])
      .range([0, width]);

  var enter = update.enter();
  
  
  enter.append("circle")
    .attr("r", 50)
    .attr("fill", "blue")
    .attr("cx", function(d, i) { Math.random } );
  
  function cxStuff() {
    debugger
    return linearScale(i)
  }
});

