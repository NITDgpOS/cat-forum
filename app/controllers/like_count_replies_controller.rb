class LikeCountRepliesController < ApplicationController
  before_action :set_like_count_reply, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /like_count_replies
  # GET /like_count_replies.json
  def index
    @like_count_replies = LikeCountReply.all
  end

  # GET /like_count_replies/1
  # GET /like_count_replies/1.json
  def show
  end

  # GET /like_count_replies/new
  def new
    @like_count_reply = LikeCountReply.new
  end

  # GET /like_count_replies/1/edit
  def edit
  end

  # POST /like_count_replies
  # POST /like_count_replies.json
  def create
    @user = User.find(current_user.id)
    @reply = Reply.find(params[:reply_id])
    @like_count_reply = @user.add_reply(@reply.id)
    @reply_user = @reply.user
    respond_to do |format|
      if @like_count_reply.save
        @like_count_reply.create_activity :create,
                                          owner: current_user,
                                          recipient: @reply.user,
                                          params: { summary: @reply.content }
        if current_user != @reply_user
          @reply_user.update_attributes(points: @reply_user.points += 25)
          @badge = @reply_user.update_badge(@reply_user.id)
          @reply_user.update_attributes(badge: @badge)
        end
        format.html { redirect_to(action: 'index', controller: 'reply') }
        format.js
        format.json do
          render :show,
                 status: :created,
                 location: @like_count_reply
        end
      else
        format.html { render :new }
        format.json do
          render json: @like_count_reply.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /like_count_replies/1
  # PATCH/PUT /like_count_replies/1.json
  def update
    respond_to do |format|
      if @like_count_reply.update(like_count_reply_params)
        format.html do
          redirect_to @like_count_reply,
                      notice: 'Like count reply was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @like_count_reply }
      else
        format.html { render :edit }
        format.json do
          render json: @like_count_reply.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /like_count_replies/1
  # DELETE /like_count_replies/1.json
  def destroy
    @like_count_reply.destroy
    respond_to do |format|
      format.html do
        redirect_to like_count_replies_url,
                    notice: 'Like count reply was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like_count_reply
    @like_count_reply = LikeCountReply.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def like_count_reply_params
    params.require(:like_count_reply).permit(:reply_id, :user_id)
  end
end
