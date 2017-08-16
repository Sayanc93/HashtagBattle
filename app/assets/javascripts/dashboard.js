// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  document.addEventListener("turbolinks:load", function() {
    $('.btn-add').on('click', function(e) {
      e.preventDefault();

      var controlForm = $('.controls form:first');
      var sampleEntry = $('.entry:last');

      $(sampleEntry.clone()).appendTo(controlForm.find('.container:first'));
    });

    $('.btn-remove').on('click', function(e) {
      e.preventDefault();

      if ($('.entry').length > 2) {
        var lastEntry = $('.entry:last');
        lastEntry.remove();
      }
    });

    $('#start-battle').on('click', function(e) {
      $('.intial-battle').addClass('hide').removeClass('show');
      $('.battle-time-option').removeClass('hide').addClass('show');
    });

    $('.battle-time-option').on('click', function(e) {
      $(this).removeClass('show').addClass('hide');
      $('.intial-battle').removeClass('hide').addClass('show');
    });

    $('#reset-counter').on('click', function(e) {
      var counters = $('.row.counter-display').children().find('var');
      counters.text('0');
    });
  });
});
