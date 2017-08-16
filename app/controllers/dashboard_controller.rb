class DashboardController < ApplicationController
  def index
  end

  def create
    hashtag_creation_service = HashtagCreationService.new(hashtag_params[:hashtags],
                                                          current_user)
    hashtag_creation_service.create_hashtags
    redirect_to dashboard_path
  end

  def initiate_battle
    create_job_to_track_hashtags
    respond_to do |format|
      format.html { render :index }
      format.js {}
    end
  end

  def terminate_battle
    current_user.update_attributes(connected: false)
    head :ok
  end

  def reset_counters
    current_user.update_attributes(connected: false)
    current_user.hashtags.find_each do |hashtag|
      hashtag.update_attributes(count: 0)
    end
    head :ok
  end

  private

    # create sidekiq job to perform tracking of tags
    def create_job_to_track_hashtags
      TwitterStreamJob.perform_later(current_user.id)
    end

    # Only allow a trusted parameter "white list" through.
    def hashtag_params
      params.permit(hashtags: [])
    end
end
