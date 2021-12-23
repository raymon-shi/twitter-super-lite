class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user, except: [:create, :new]
  before_action :check_user_is_user_users, only: [:edit, :update, :destroy]

  require 'quotify'
  require 'fact_is_fact'

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.all
    @fact = FactIsFact.return(type: 'date', number: 'random')
    @quote = Quotify.generate.to_s
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.password = user_params[:password_hash]
    @user.save
    respond_to do |format|
      if @user.save

        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.assign_attributes(user_params)
        @user.password = user_params[:password_hash]
        @user.save
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def following
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_to(user_path(@user))
  end

  def unfollowing
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to(user_path(@user))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :birthday, :bio, :password_hash, :location)
    end

    def check_user_is_user_users
      if not @user == current_user
        redirect_to current_user
      end
    end
end
