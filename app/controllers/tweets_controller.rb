class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :check_tweet_owner_same, only: [:edit, :destroy, :show]

  # GET /tweets or /tweets.json
  # def index
  #   @tweets = Tweet.all
  # end

  # GET /tweets/1 or /tweets/1.json
  def show
    @tweets = Tweet.all
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @user = current_user

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to current_user, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:user_id, :content)
    end

    def check_tweet_owner_same
      if not @tweet.user_id == current_user.id
        redirect_to current_user
      end
    end
end
