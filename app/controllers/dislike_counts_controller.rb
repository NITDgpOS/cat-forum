class DislikeCountsController < ApplicationController
  before_action :set_dislike_count, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /dislike_counts
  # GET /dislike_counts.json
  def index
    @dislike_counts = DislikeCount.all
  end

  # GET /dislike_counts/1
  # GET /dislike_counts/1.json
  def show
  end

  # GET /dislike_counts/new
  def new
    @dislike_count = DislikeCount.new
  end

  # GET /dislike_counts/1/edit
  def edit
  end

  # POST /dislike_counts
  # POST /dislike_counts.json
  def create
    @user = User.find(current_user.id)
    @new_thread = NewThread.friendly.find(params[:new_thread_id])
    @dislike_count = @user.add_new_thread_dislike(@new_thread.id)
    @thread_user = @new_thread.user
    respond_to do |format|
      if @dislike_count.save
        if current_user != @thread_user
          @thread_user.update_attributes(points: @thread_user.points -= 10)
          @badge = @thread_user.update_badge(@user.id)
          @thread_user.update_attributes(badge: @badge)
        end
        # format.html { redirect_to(@like_count.user, :notice => 'Line item was successfully created.' ) }
        format.html { redirect_to(action: 'index', controller: 'new_threads') }
        format.js
        format.json { render :show, status: :created, location: @dislike_count }
        # redirect_to(:action => 'show', :controller => 'user', :user_id => @user.user_id)
      else
        format.html { render :new }
        format.json { render json: @dislike_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dislike_counts/1
  # PATCH/PUT /dislike_counts/1.json
  def update
    respond_to do |format|
      if @dislike_count.update(dislike_count_params)
        format.html { redirect_to @dislike_count, notice: 'Dislike count was successfully updated.' }
        format.json { render :show, status: :ok, location: @dislike_count }
      else
        format.html { render :edit }
        format.json { render json: @dislike_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dislike_counts/1
  # DELETE /dislike_counts/1.json
  def destroy
    @dislike_count.destroy
    respond_to do |format|
      format.html { redirect_to dislike_counts_url, notice: 'Dislike count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dislike_count
    @dislike_count = DislikeCount.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dislike_count_params
    params.require(:dislike_count).permit(:new_thread_id, :user_id)
  end
end
