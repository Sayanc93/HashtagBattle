class HashtagCounterChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "hashtag_counter_#{params[:user][:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
