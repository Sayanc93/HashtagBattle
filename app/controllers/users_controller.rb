class UsersController < ApplicationController

  # GET /user/1/edit
  def edit
  end

  # PATCH/PUT /user/1
  def update
    current_user.hashtags.delete_all
    hashtag_creation_service = HashtagCreationService.new(user_params[:hashtags],
                                                          current_user)
    hashtag_creation_service.create_hashtags
    redirect_to dashboard_path
  end

  private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:user_id, hashtags: [])
    end
end
