class LikeCountsController < ApplicationController
  before_action :set_like_count, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /dislike_counts
  # GET /dislike_counts.json
  def index
    @like_counts = LikeCount.all
  end

  # GET /dislike_counts/1
  # GET /dislike_counts/1.json
  def show
  end

  # GET /dislike_counts/new
  def new
    @like_count = LikeCount.new
  end

  # GET /dislike_counts/1/edit
  def edit
  end
  # GET /like_counts/1/edit

  # POST /like_counts
  # POST /like_counts.json
  def create
    @user = User.find(current_user.id)
    @new_thread = NewThread.friendly.find(params[:new_thread_id])
    @like_count = @user.add_new_thread(@new_thread.id)
    @thread_user = @new_thread.user
    respond_to do |format|
      if @like_count.save
        @like_count.create_activity :create,
                                    owner: current_user,
                                    recipient: @new_thread.user
        if current_user != @thread_user
          @thread_user.update_attributes(points: @thread_user.points += 15)
          @badge = @thread_user.update_badge(@thread_user.id)
          @thread_user.update_attributes(badge: @badge)
        end
        # format.html do
        #   redirect_to(
        #     @like_count.user,
        #     :notice => 'Line item was successfully created.'
        #   )
        # end
        format.html { redirect_to(action: 'index', controller: 'new_threads') }
        format.js
        format.json { render :show, status: :created, location: @like_count }
        # redirect_to(
        #   :action => 'show',
        #   :controller => 'user',
        #    :user_id => @user.user_id
        # )
      else
        format.html { render :new }
        format.json do
          render json: @like_count.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /like_counts/1
  # PATCH/PUT /like_counts/1.json

  # DELETE /like_counts/1
  # DELETE /like_counts/1.json

  private

  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def like_count_params
    params.require(:like_count).permit(:new_thread_id, :user_id)
  end
end
