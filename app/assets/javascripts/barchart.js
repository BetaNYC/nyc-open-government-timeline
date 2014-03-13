d3.json('/events.json', function (events) {
  // reads json served from rails
  var preDataHash = getEvents(events);
  // preDataHash = {"2000":3, "2001":4, "1999":1}

  //makes json objects into nested array with year and count of events
  var sortedByYear = makeTwoDArray(preDataHash);
  // sortedByYear = [ [ '1999', 1 ], [ '2000', 3 ], [ '2001', 4 ] ]

  //gets min year in arrays
  var xMin = sortedByYear[0][0];
  //gets max year in arrays
  var xMax = sortedByYear[(sortedByYear.length - 1)][0];
  //get the difference between min and max years
  var range = xMax - xMin;
  //sorts arrays by number of events
  var sortedByValue = sortArraysByValue(sortedByYear);
  //sets width and height of barchart
  var yMin = 0;
  //sets y max to max number of events
  var yMax = sortedByValue[(sortedByValue.length - 1)][1];

  //add zero values to years not present in preDataHash
  var dataHash = addMissingYears(preDataHash, xMin, xMax);

  // d3 begins ///////////////////////////////////////////////
  
  //makes json objects into nested array with year and count of events
  var data = makeTwoDArray(dataHash);
  // data = [["1974",2],["1975",0],["1976",0],["1977",0],["1978",0]...]

  var xRange = flattenArray(data, 0);

  var yRange = flattenArray(data, 1);

  var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 1000 - margin.left - margin.right,
    height = 600 - margin.top - margin.bottom;

  var barWidth = width/xRange.length;

   var x = d3.scale.linear() // TODO use d3.time.scale
     .domain([xMin, xMax])
     .range([0, width]);

   var y = d3.scale.linear()
     .domain([yMin, yMax])
     .range([height, 0]);

   var xAxis = d3.svg.axis()
     .scale(x)
     .orient("bottom")
     .tickFormat(d3.format("0000")); // 4-digit years

   var yAxis = d3.svg.axis()
     .scale(y)
     .orient("left");

   var chart = d3.select(".barchart")
     .attr("width", width + margin.left + margin.right)
     .attr("height", height + margin.top + margin.bottom)
    .append("g")
     .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

   chart.append("g")
     .attr("class", "x axis")
     .attr("transform", "translate(0," + height + ")")
     .call(xAxis);

   chart.append("g")
     .attr("class", "y axis")
     .call(yAxis);

   chart.selectAll(".bar")
     .data(data)
     .enter().append("rect")
     .attr("class", "bar")
     .attr("x", function (d, i) {
       return x(d[0])
     })
     .attr("y", function (d) {
       return y(d[1]);
     })
     .attr("height", function (d) {
       return height - y(d[1]);
     })
     .attr("width", barWidth)
     .attr("stroke", "black");


  ////// SVG / D3 End, Functions for getting data begin ///////////////////////////////

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

  function flattenArray(data, index) {
    var array = [];
    var counter = 0;
    while (counter < data.length) {
      array.push(data[counter][index]);
      counter += 1;
    }
    return array;
  }

});