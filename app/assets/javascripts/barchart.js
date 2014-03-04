d3.json('/events.json', function (events) {
  // reads json served from rails
  // {"2000":3, "2001":4, "1999":1}
  var preDataHash = getEvents(events);

  //makes json objects into nested array with year and count of events
  // [ [ '1999', 1 ], [ '2000', 3 ], [ '2001', 4 ] ]
  var sortedByYear = makeTwoDArray(preDataHash);
  //gets min year in arrays
  var xMin = sortedByYear[0][0];
  //gets max year in arrays
  var xMax = sortedByYear[(sortedByYear.length - 1)][0];
  //get the difference between min and max years
  var range = xMax - xMin;
  //sets y min to zero
  //sorts arrays by number of events
  var sortedByValue = sortArraysByValue(sortedByYear);
  //sets width and height of barchart
  var yMin = 0;
  //sets y max to max number of events
  var yMax = sortedByValue[(sortedByValue.length - 1)][1];

  //add zero values to years not present in preDataHash
  var dataHash = addMissingYears(preDataHash, xMin, xMax);
  //makes json objects into nested array with year and count of events
  var oneLastThingData = makeTwoDArray(dataHash);
  // make array with just the values of each year
  // [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 3, 2, 0, 1, 2, 0, 1, 11, 4, 4, 10, 21] 
 
  var data = flattenArray(oneLastThingData);

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

  function makeTwoDArray(hash) {
    var array = [];
    var arrays = [];
    for (var i in hash) {
      array.push(i);
      array.push(hash[i]);
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
      if (events[i].categories.length) {
        eventCounter++;
        var ourEvent = events[i];
        var ourDate = new Date(ourEvent.date);
        var ourYear = ourDate.getFullYear();
        if (container[ourYear] === undefined) {
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
      if (data[xMin] === undefined) {
        data[xMin] = 0;
      }
      var temp = parseInt(xMin);
      temp += 1;
      xMin = temp.toString();
    }
    return data;
  }

  function flattenArray(data) {
    var array = [];
    var counter = 0;
    while (counter < data.length) {
      array.push(data[counter][1]);
      counter += 1;
    }
    return array;
  }

  //set dimensions for chart
  var width = 800,
    barHeight = 10;

  //create linear scale 
  var linearScale = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, width]);

  //select chart and set it to the dimensions
  var chart = d3.select(".barchart")
    .attr("width", width)
    .attr("height", barHeight * data.length);

  //select elements and bind data to them
  // bar will be a rect and text
  var barUpdate = chart.selectAll("g")
    .data(data);

  //since there are no bars, all exist in enter
  //add them to the DOM
  barUpdate.enter().append("g")
    .attr("transform", function (d, i) {
      return "translate(0," + i * barHeight + ")";
      //"transform: translate(0, 40)"
    });

  //add the shape so we can see it!
  barUpdate.append("rect")
    .attr("width", linearScale)
    .attr("height", barHeight - 3);

  //add the text to explain it
  barUpdate.append("text")
    .attr("x", function (d) {
      return linearScale(d - 1);
    })
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function (d) {
      return d;
    });

});