class FeedsController < ApplicationController
  before_action :set_feed, only: %i[ show edit update destroy ]

  # GET /feeds or /feeds.json
  def index
    @feeds = Feed.all
    @tweets = Tweet.all
    @users = User.all
  end

  # # GET /feeds/1 or /feeds/1.json
  # def show
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_params
      params.fetch(:feed, {})
    end
end
