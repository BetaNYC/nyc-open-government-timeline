$(document).ready(function() {
  createStoryJS({
      type:       'timeline',
      width:      '100%',
      height:     '700',
      source:     '/timelineJS.json',
      embed_id:   'my-timeline'
  });

});

$(document).ready(function() { 
  var check = function(){
    if($(".timenav-tag-size-half").children().children().length == 5) {
      $(".timenav-tag-size-half").children().children().css({'color': '#484848'});
    } else {
      setTimeout(check, 1000); // check again in a second
    }
  }
  check();
});