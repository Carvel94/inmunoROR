$(function() {
  $('#loading-indicator').delay(3000).hide();  // hide it initially.
  $(document)  
    .ajaxStart(function() {
      $('#loading-indicator').delay(3000).show(); // show on any Ajax event.
    })
    .ajaxStop(function() {
      $('#loading-indicator').delay(3000).hide(); // hide it when it is done.
  });
});