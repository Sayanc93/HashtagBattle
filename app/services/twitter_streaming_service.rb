class TwitterStreamingService

  attr_reader :client, :user

  def initialize user = nil
    @user = user
    @client = TweetStream::Client.new(oauth_token_secret: user.secret,
                                      oauth_token: user.token)
  end

  # Tracks tweets in a stream, stream exits when user's connected attribute is toggled.
  def track hashtag
    client.track(hashtag.name) do |tweet, client|
      client.stop if !user.reload.connected
      hashtag = user.hashtags.find_by(name: hashtag.name)
      hashtag.count = hashtag.count + 1
      hashtag.save!
      broadcast_counter_data hashtag
    end
  end

  # Broadcasts the counter to the relevant user with tag information.
  def broadcast_counter_data hashtag
    ActionCable.server.broadcast("hashtag_counter_#{user.id}",
                                 hashtag: hashtag.name,
                                 counter: hashtag.count)
  end
end
