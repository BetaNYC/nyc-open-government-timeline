 $(document).ready(function() {
  createStoryJS({
      type:       'timeline',
      width:      '100%',
      height:     '700',
      source:     '/timelineJS.json',
      embed_id:   'my-timeline'
  });

  $(".date").remove();
});