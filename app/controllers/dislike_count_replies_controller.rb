class DislikeCountRepliesController < ApplicationController
  before_action :set_dislike_count_reply,
                only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /dislike_count_replies
  # GET /dislike_count_replies.json
  def index
    @dislike_count_replies = DislikeCountReply.all
  end

  # GET /dislike_count_replies/1
  # GET /dislike_count_replies/1.json
  def show
  end

  # GET /dislike_count_replies/new
  def new
    @dislike_count_reply = DislikeCountReply.new
  end

  # GET /dislike_count_replies/1/edit
  def edit
  end

  # POST /dislike_count_replies
  # POST /dislike_count_replies.json
  def create
    @user = User.find(current_user.id)
    @reply = Reply.find(params[:reply_id])
    @dislike_count_reply = @user.add_reply_dislike(@reply.id)
    @reply_user = @reply.user
    respond_to do |format|
      if @dislike_count_reply.save
        if current_user != @reply_user
          @reply_user.update_attributes(points: @reply_user.points -= 15)
          @badge = @reply_user.update_badge(@reply_user.id)
          @reply_user.update_attributes(badge: @badge)
        end
        # format.html do
        #   redirect_to(
        #     @like_count.user,
        #     :notice => 'Line item was successfully created.'
        #   )
        # end
        format.html { redirect_to(action: 'index', controller: 'reply') }
        format.js
        format.json do
          render :show,
                 status: :created,
                 location: @dislike_count_reply
        end
        # redirect_to(
        #   :action => 'show',
        #   :controller => 'user',
        #   :user_id => @user.user_id
        # )
      else
        format.html { render :new }
        format.json do
          render json: @dislike_count_reply.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /dislike_count_replies/1
  # PATCH/PUT /dislike_count_replies/1.json
  def update
    respond_to do |format|
      if @dislike_count_reply.update(dislike_count_reply_params)
        format.html do
          redirect_to @dislike_count_reply,
                      notice: 'Dislike count reply was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @dislike_count_reply
        end
      else
        format.html { render :edit }
        format.json do
          render json: @dislike_count_reply.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /dislike_count_replies/1
  # DELETE /dislike_count_replies/1.json
  def destroy
    @dislike_count_reply.destroy
    respond_to do |format|
      format.html do
        redirect_to dislike_count_replies_url,
                    notice: 'Dislike count reply was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dislike_count_reply
    @dislike_count_reply = DislikeCountReply.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def dislike_count_reply_params
    params.require(:dislike_count_reply).permit(:reply_id, :user_id)
  end
end
