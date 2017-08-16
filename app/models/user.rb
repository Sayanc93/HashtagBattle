class User < ApplicationRecord
  has_many :hashtags

  # Create user with credentials if it doesn't already exist in DB.
  def self.from_omniauth(auth)
    current_user = where(uid: auth.uid)
                    .first_or_create(name: auth.info.name,
                                     token: auth.credentials.token,
                                     secret: auth.credentials.secret,
                                     provider: auth.provider)
    current_user
  end
end
