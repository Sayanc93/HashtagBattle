class TwitterStreamJob < ApplicationJob

  def perform(user_id = nil)
    user = User.find(user_id)
    hashtags = user.hashtags
    user.update_attributes(connected: true)
    run_stream_in_parallel user, hashtags
  end

  def run_stream_in_parallel user, hashtags
    streaming_service = TwitterStreamingService.new(user)
    Parallel.each(hashtags.each, in_threads: hashtags.size) do |hashtag|
      ActiveRecord::Base.connection_pool.with_connection do
        streaming_service.track hashtag
      end
    end
  end
end
