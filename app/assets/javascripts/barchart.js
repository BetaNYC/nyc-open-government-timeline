d3.json('/events.json', function(events){
  var data = getEvents(events);
  var twoDArray = makeTwoDArray(data);
  var sortedByFirst = sortArraysByFirst(twoDArray);
  var sortedBySecond = sortArraysBySecond(twoDArray);
  var range = getTimeRange(twoDArray);
  var width = 800;
  var height = 800;

  function makeTwoDArray(events) {
    var array = [];
    var arrays = [];
    for (var i in events) {
      array.push(i);
      array.push(events[i]);
    }
    while (array.length > 0) {
      arrays.push(array.splice(0, 2));
    }
    return sortArraysByFirst(arrays);
  }

  function sortArraysbyFirst(arrays) {
    arrays.sort(function (a, b) {
      return a[0] - b[0];
    });
    return arrays;
  }

  function sortArraysbySecond(arrays) {
    arrays.sort(function (b, a) {
      return b[0] - a[0];
    });
    return arrays;
  }

//range is number of potential bars i.e., num of years on x axis
  function getTimeRange(arrays) {
    var range = arrays[arrays.length-1][0] - arrays[0][0];
    return range;
  }

  function getEvents(events) {
    var container = {};
    var eventCounter = 0;
    for (i = 0; i < events.length; i++) {
      if (events[i].categories.length) {  // if the length of the events categories array is NOT equal to zero
        eventCounter++;
        // {id: 1, lane: 0, desc: 'Qin', start: ourDate("03", "19", "1991"), end: ourDate("03", "19", "1997"), class: 'item'},
        var ourEvent = events[i];
        var ourDate = new Date(ourEvent.date);
        var ourYear = ourDate.year;
        // var ourYear = ourDate.substr(0,4)
        if (container[ourYear] == undefined) {
          container[ourYear] = 1;
        } else {
          var num = container[ourYear];
          container[ourYear] = num += 1;
        }
      }
    }
    return container;
  }
    
  var height = 800,
    barWidth = (800/range);

  var linearScale = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, width]);

  var chart = d3.select(".barchart")
    .attr("width", width)
    .attr("height", barHeight );

  //select elements and bind data to them
  // bar will be a rect and text
  var barUpdate = chart.selectAll("g")
    .data(data);

  //since there are no bars, all exist in enter
  //add them to the DOM
  barUpdate.enter().append("g")
    .attr("transform", function(d){
      return "translate(0," + year - 1975 * barHeight + ")";
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

});