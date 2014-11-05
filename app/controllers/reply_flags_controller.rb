class ReplyFlagsController < ApplicationController
  # before_action :set_reply_flag, only: [:show, :edit, :update, :destroy]

  # GET /reply_flags
  # GET /reply_flags.json
  def index
    @replies = Reply.all
  end

  # GET /reply_flags/1
  # GET /reply_flags/1.json
  def show
  end

  # GET /reply_flags/new
  def new
    @reply_flag = ReplyFlag.new
  end

  # GET /reply_flags/1/edit
  def edit
  end

  # POST /reply_flags
  # POST /reply_flags.json
  def create
    @user = User.find(current_user.id)
    @reply = Reply.find(params[:reply_id])
    @reply_flag = @user.add_reply_flag(@reply.id)
    respond_to do |format|
      if @reply_flag.save
        format.html { redirect_to @reply_flag, notice: 'Reply flag was successfully created.' }
        format.json { render :show, status: :created, location: @reply_flag }
        format.js
      else
        format.html { render :new }
        format.json { render json: @reply_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reply_flags/1
  # PATCH/PUT /reply_flags/1.json
  def update
    respond_to do |format|
      if @reply_flag.update(reply_flag_params)
        format.html { redirect_to @reply_flag, notice: 'Reply flag was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply_flag }
      else
        format.html { render :edit }
        format.json { render json: @reply_flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reply_flags/1
  # DELETE /reply_flags/1.json

  

  def destroy
    @reply = Reply.find(params[:id])
     Reply.find(params[:id]).destroy
     respond_to do |format|
     format.html {redirect_to(:action => 'index', :controller => 'flags')}
     format.json { render action: 'index', status: :created, location: @reply_flag }
     format.js
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply_flag
      @reply_flag = ReplyFlag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_flag_params
      params.require(:reply_flag).permit(:reply_id, :user_id)
    end
end
