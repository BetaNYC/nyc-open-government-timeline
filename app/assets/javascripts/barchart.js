d3.json('/events.json', function (events) {
  // reads json served from rails
  var preDataHash = getEvents(events);
  // preDataHash = {"2000":3, "2001":4, "1999":1}

  //makes json objects into nested array with year and count of events
  // sortedByYear = [ [ '1999', 1 ], [ '2000', 3 ], [ '2001', 4 ] ]
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

  var domain = flattenArray(oneLastThingData, 0);
  var range = flattenArray(oneLastThingData, 1);
  // domain = ["1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013"]
  // range = [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 3, 2, 0, 1, 2, 0, 1, 11, 4, 4, 10, 21] 

  var data = d3.scale.ordinal()
    .domain(domain)
    .range(range);

  // SVG D3 Begins ###################################################################################

  var width = 800,
      height = 600;

  var y = d3.scale.linear()
      .range([height, 0]);

  var chart = d3.select(".barchart")
      .attr("width", width)
      .attr("height", height);

  var barWidth = width / data.length;

  var bar = chart.selectAll("g")
      .data(data)
    .enter().append("g")
      .attr("transform", function(d, i) { return "translate(" + i * barWidth + ",0)"; });

  bar.append("rect")
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", barWidth - 1);

  bar.append("text")
      .attr("x", barWidth / 2)
      .attr("y", function(d) { return y(d.value) + 3; })
      .attr("dy", ".75em")
      .text(function(d) { return d.value; });

  function type(d) {
    d.value = +d.value; // coerce to number
    return d;
  }

 // Functions for data begin ###################################################################################

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