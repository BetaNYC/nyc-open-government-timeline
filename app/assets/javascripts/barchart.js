//create data
d3.json('/categories.json', function(categories){
  d3.json('/events.json', function(events){

    var lanes = getCategories(categories);
    var items = getEvents(events);

//create data
var data = [4,8,15,16,23,42];

//set dimensions for chart
var width = 420,
    barHeight = 20;

//create linear scale 
var linearScale = d3.scale.linear()
  .domain([0, d3.max(data)])
  .range([0, width]);

//select chart and set it to the dimensions
var chart = d3.select(".chart")
  .attr("width", width)
  .attr("height", barHeight * data.length);

//select elements and bind data to them
// bar will be a rect and text
var barUpdate = chart.selectAll("g")
  .data(data);

//since there are no bars, all exist in enter
//add them to the DOM
barUpdate.enter().append("g")
  .attr("transform", function(d,i){
    return "translate(0," + i * barHeight + ")";
    //"transform: translate(0, 40)"
  });

//add the shape so we can see it!
barUpdate.append("rect")
  .attr("width", linearScale)
  .attr("height", barHeight - 3);

//add the text to explain it
barUpdate.append("text")
  .attr("x", function(d){
    return linearScale(d - 1);
  })
  .attr("y", barHeight / 2)
  .attr("dy", ".35em")
  .text(function(d){
    return d;
  });