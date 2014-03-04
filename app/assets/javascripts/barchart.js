d3.json('/events.json', function(events){
  //reads json served from rails
  var preDataHash = getEvents(events);
  //makes json objects into nested array with year and count of events
  var twoDArray = makeTwoDArray(preDataHash);
  //sorts arrays by year
  var sortedByYear = sortArraysByYear(twoDArray);
  //sorts arrays by number of events
  var width = 800;
  var height = 800;

  //gets min year in arrays
  var xMin = sortedByYear[0][0];
  //gets max year in arrays
  var xMax = sortedByYear[(sortedByYear.length-1)][0];
  //get the difference between min and max years
  var range = xMax - xMin;
  //sets y min to zero

  var sortedByValue = sortArraysByValue(twoDArray);
  //sets width and height of barchart
  var yMin = 0;
  //sets y max to max number of events
  var yMax = sortedByValue[(sortedByValue.length-1)][1] + 1;
  
  //add zero values to years not present in preDataHash
  var dataHash = addMissingYears(preDataHash, xMin, xMax);
  //makes json objects into nested array with year and count of events
  var data = makeTwoDArray(dataHash);
  console.log(data);

  function sortArraysByYear(arrays) {
    arrays.sort(function (a, b) {
      return a[0] - b[0];
    });
    return arrays;
  }

  function sortArraysByValue(arrays) {
    arrays.sort(function (b, a) {
      return b[0] - a[0];
    });
    return arrays;
  }

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
    return sortArraysByYear(arrays);
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
        if (ourYear in container) {
          container[ourYear] = 1;
        } else {
          var num = container[ourYear];
          container[ourYear] = num += 1;
        }
      }
    }
    return container;
  }

  function addMissingYears(data, xMin, xMax) {
    while (xMin < xMax) {
      if (!xMin in data) {
        data[xMin] = 0;
      }
      xMin += 1;
    }
    return data;
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