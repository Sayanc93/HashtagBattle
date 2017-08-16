class HashtagCreationService

  attr_reader :user, :hashtag_params

  def initialize hashtag_params = [], user = nil
    @hashtag_params = hashtag_params
    @user = user
  end

  def create_hashtags
    return unless user
    sanitized_hashtags.each do |hashtag|
      user.hashtags.where(name: hashtag).first_or_create!
    end
  end

  # Sanitize hashtags. 'cat' gets transformed into '#cat' if not passed.
  def sanitized_hashtags
    modified_tags = hashtag_params.map do |hashtag|
                      hashtag.first != '#' ? hashtag.prepend('#') : hashtag
                    end
    modified_tags
  end
end
