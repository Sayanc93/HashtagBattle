App.hashtag_counter = App.cable.subscriptions.create({
  channel: "HashtagCounterChannel",
  user: gon.current_user
}, {
  connected: function() {
    console.log('connected');
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    hashtag = data.hashtag;
    selector = '#' + hashtag.slice(1) + "_counter"
    $(selector).text(data.counter);
  }
});
