$(function () {
  setTimeout(function() {
    $('.itemLabel').hide();
    $('.mainItem').on('click', function() {
      var $this = $(this);
      var id = $this.data().id;
      var label = $('.itemLabel[data-id=' + id + ']');
      alert(label.text());
    });   
  }, 500);
});
