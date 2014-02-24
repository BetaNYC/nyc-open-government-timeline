d3.json('http://localhost:3000/categories.json', function(categories){
  d3.json('http://localhost:3000/events.json', function(events){

    var catLanes = [];
    for (i=0; i<categories.length; i++) {
      catLanes.push({id: categories[i].id, label: categories[i].name})
    }
    console.log(catLanes);
    var lanes = [
        {id: 0, label: 'Chinese'}, 
        {id: 1, label: 'Japanese'}, 
        {id: 2, label: 'Korean'},
        {id: 3, label: 'Poop'},
        ];

        // console.log(categories);
        // console.log(events);


        // items is an array of item objects that have the following properties

        //    id:    the unique id for this item

        //    lane:  the id of the lane that this item belongs in

        //    desc:  the description for this item

        //    start: the starting value for this item

        //    end:   the end value for this item

        //    class: the css class that should be applied to this item

        //    

        // these define the actual items that are displayed on the chart

        function ourDate(month, day, year) {
          return new Date(year +","+ month +","+ day);
        }

        function addSpace(date) {
          day = date.getDay();
          month = date.getMonth();
          year = Number(date.getFullYear());
          year += 5
          return new Date(year, month, day)
        }

        var items = [
        {id: 0, lane: 1, desc: 'Qin', start: ourDate("03", "19", "1991"), end: ourDate("03", "19", "1992"), class: 'item'},
        {id: 0, lane: 1, desc: 'Qin', start: ourDate("03", "19", "1993"), end: ourDate("03", "19", "1994"), class: 'item'},
        {id: 1, lane: 2, desc: 'Jin', start: ourDate("03", "19", "2001"), end: ourDate("03", "19", "2013"), class: 'item'},
        {id: 2, lane: 3, desc: 'Jin', start: ourDate("05", "07", "2000"), end: ourDate("03", "19", "2007"), class: 'item'}
        ];  



        // define the chart extents

        var margin = {top: 20, right: 15, bottom: 15, left: 70}
        , width = $(window).width() - margin.left - margin.right - 20
        , height = $(window).height() - margin.top - margin.bottom - 20
        , miniHeight = lanes.length * 12 + 50
        , mainHeight = height - miniHeight - 50;


        var x = d3.time.scale()
        .domain([d3.min(items, function(d) { return d.start - 100000; }),
             d3.max(items, function(d) { return d.end; })])
        .range([0, width]);

        var x1 = d3.time.scale().range([0, width]);



        var ext = d3.extent(lanes, function(d) { return d.id; });

        var y1 = d3.scale.linear().domain([ext[0], ext[1] + 1]).range([0, mainHeight]); // domain is [lanes.min, lanes.max + 1]

        var y2 = d3.scale.linear().domain([ext[0], ext[1] + 1]).range([0, miniHeight]);


        // y1 is the scaling factor of the big swim lames
        // y2 is the scaling factor of the mini swim lanes


        var chart = d3.select('body')
        .append('svg:svg')
        .attr('width', width + margin.right + margin.left)
        .attr('height', height + margin.top + margin.bottom)
        .attr('class', 'chart');



        chart.append('defs').append('clipPath')
        .attr('id', 'clip')
        .append('rect')
          .attr('width', width)
          .attr('height', mainHeight);



        var main = chart.append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
        .attr('width', width)
        .attr('height', mainHeight)
        .attr('class', 'main');


        var mini = chart.append('g')
        .attr('transform', 'translate(' + margin.left + ',' + (mainHeight + 60) + ')')
        .attr('width', width)
        .attr('height', miniHeight)
        .attr('class', 'mini');



        // draw the lanes for the main chart

        main.append('g').selectAll('.laneLines')
        .data(lanes)
        .enter().append('line')
        .attr('x1', 0)
        .attr('y1', function(d) { return d3.round(y1(d.id));})
        .attr('x2', width)
        .attr('y2', function(d) { return d3.round(y1(d.id));})
        .attr('stroke', function(d) { return 'blue' });


        // BETANYC lane colors

        main.append("g").selectAll('.laneBackground')
        .data(lanes)
        .enter().append('rect')
        .attr('width', width)
        .attr('height', (mainHeight/lanes.length) - 10 )
        .attr("y", function(d) { return d3.round(y1(d.id));})


        // BETANYC1: STROKE AND FILL CAN BE RANDOMIZED OR CHOSEN BASED ON CATEGORY NAME


        main.append('g').selectAll('.laneText')
        .data(lanes)
        .enter().append('text')
        .text(function(d) { return d.label; })
        .attr('x', -10)
        .attr('y', function(d) { return y1(d.id + .5); })
        .attr('dy', '0.5ex')
        .attr('text-anchor', 'end')
        .attr('class', 'laneText');


        // draw the lanes for the mini chart

        mini.append('g').selectAll('.laneLines')
        .data(lanes)
        .enter().append('line')
        .attr('x1', 0)
        .attr('y1', function(d) { return d3.round(y2(d.id)) + 0.5; }) // scaling the numb of lanes to the height of the big swim lane
        .attr('x2', width) 
        .attr('y2', function(d) { return d3.round(y2(d.id)) + 0.5; })
        .attr('stroke', function(d) { return d.label === '' ? 'white' : 'lightgray' });



        mini.append('g').selectAll('.laneText')
        .data(lanes)
        .enter().append('text')
        .text(function(d) { return d.label; })
        .attr('x', -10)
        .attr('y', function(d) { return y2(d.id + .5); })
        .attr('dy', '0.5ex')
        .attr('text-anchor', 'end')
        .attr('class', 'laneText');



        // draw the x axis

        var xDateAxis = d3.svg.axis()
        .scale(x)
        .orient('bottom');




        var x1DateAxis = d3.svg.axis()
        .scale(x1)
        .orient('bottom');


        //poop
        main.append('g')
        .attr('transform', 'translate(0,' + mainHeight + ')')
        .attr('class', 'main axis date')
        .call(x1DateAxis);



        mini.append('g')
        .attr('transform', 'translate(0,' + miniHeight + ')')
        .attr('class', 'axis date')
        .call(xDateAxis);



        // draw the items

        var itemRects = main.append('g')
        .attr('clip-path', 'url(#clip)');



        mini.append('g').selectAll('miniItems')
        .data(getPaths(items))
        .enter().append('path')
        .attr('class', function(d) { return 'miniItem ' + d.class; })
        .attr('d', function(d) { return d.path; });



        // invisible hit area to move around the selection window

        mini.append('rect')
        .attr('pointer-events', 'painted')
        .attr('width', width)
        .attr('height', miniHeight)
        .attr('visibility', 'hidden')
        .on('mouseup', moveBrush);



        // draw the selection area

        var brush = d3.svg.brush()
        .x(x)
        .extent([ourDate("03", "19", "2001"), ourDate("03", "19", "2013")])
        .on("brush", display);



        mini.append('g')
        .attr('class', 'x brush')
        .call(brush)
        .selectAll('rect')
          .attr('y', 1)
          .attr("fill", "yellow")
          .attr('height', miniHeight - 1);



        mini.selectAll('rect.background').remove();

        display();



        function display () {


        var rects, labels
          , minExtent = brush.extent()[0]
          , maxExtent = brush.extent()[1]
          , visItems = items.filter(function (d) { return d.start < maxExtent && d.end > minExtent});


        mini.select('.brush').call(brush.extent([minExtent, maxExtent]));   


        x1.domain([minExtent, maxExtent]);


        // update the axis
        main.select('.main.axis.date').call(x1DateAxis);


        // upate the item rects
        rects = itemRects.selectAll('rect')
          .data(visItems, function (d) { return d.id; })
          .attr('x', function(d) { return x1(d.start); })
          .attr('width', function(d) { return x1(d.end) - x1(d.start); });


        rects.enter().append('rect')
          .attr('x', function(d) { return x1(d.start); })
          .attr('y', function(d) { return y1(d.lane) + .1 * y1(1) + 0.5; })
          .attr('width', function(d) { return x1(d.end) - x1(d.start); })
          .attr('height', function(d) { return .8 * y1(1); })
          .attr('class', function(d) { return 'mainItem ' + d.class; });


        rects.exit().remove();


        // update the item labels
        labels = itemRects.selectAll('text')
          .data(visItems, function (d) { return d.id; })
          .attr('x', function(d) { return x1(Math.max(d.start, minExtent)) + 2; });
              
        labels.enter().append('text')
          .text(function (d) { return 'Item\n\n\n\n Id: ' + d.id; })
          .attr('x', function(d) { return x1(Math.max(d.start, minExtent)) + 2; })
          .attr('y', function(d) { return y1(d.lane) + .4 * y1(1) + 0.5; })
          .attr('text-anchor', 'start')
          .attr('class', 'itemLabel');


        labels.exit().remove();

        }



        function moveBrush () {
        var origin = d3.mouse(this)
          , point = x.invert(origin[0])
          , halfExtent = (brush.extent()[1].getTime() - brush.extent()[0].getTime()) / 2
          , start = new Date(point.getTime() - halfExtent)
          , end = new Date(point.getTime() + halfExtent);


        brush.extent([start,end]);
        display();

        }



        // generates a single path for each item class in the mini display

        // ugly - but draws mini 2x faster than append lines or line generator

        // is there a better way to do a bunch of lines as a single path with d3?

        function getPaths(items) {
        var paths = {}, 
            d, 
            offset = .5 * y2(1) + 0.5, 
            result = [];

        for (var i = 0; i < items.length; i++) {
          d = items[i];
          if (!paths[d.class]) paths[d.class] = ''; 
          paths[d.class] += ['M',x(d.start),(y2(d.lane) + offset),'H',x(d.end)].join(' ');
        }


        for (var className in paths) {
          result.push({class: className, path: paths[className]});
        }


        return result;

        }
  });
});

