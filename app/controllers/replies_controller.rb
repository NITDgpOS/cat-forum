class RepliesController < ApplicationController
  
  # before_filter :confirm_logged_in
  before_filter :find_new_thread
  before_action :authenticate_user!, except: [:index, :list, :show]

  def index
    list
    render('list')
  end
  
  def list
    @replies = Reply.all
  end

  def show
  end


  def edit
    @reply = Reply.find(params[:id])
    @new_thread = NewThread.friendly.find(params[:new_thread_id])
  end
  
  def new
    @reply = Reply.new
  end
  
  def create
    @new_thread = NewThread.friendly.find(params[:new_thread_id])
    @reply = @new_thread.replies.create(reply_params)
    @user = @new_thread.user

    respond_to do |format|
      if @reply.save
        if current_user != @user
        @user.update_attributes(points: @user.points+=5)
        @badge = @user.update_badge(@user.id)
        @user.update_attributes(badge: @badge)
        end
        @reply.create_activity :create, owner: current_user, recipient: @new_thread.user
        format.html { redirect_to @new_thread, notice: 'Reply was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reply }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @reply = Reply.find(params[:id])
    # @new_thread = NewThread.find(:new_thread_id)
    respond_to do |format|
      if @reply.update(reply_params)
        # @reply.create_activity :update, owner: current_user, recipient: @new_thread.user
        format.html { redirect_to @new_thread, notice: 'Reply was successfully updated.' }
        format.json {respond_with_bip(@reply)}
      else
        format.html { render action: 'edit' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete
    @reply = Reply.find(params[:id])
  end
  
  def destroy
    @reply = Reply.find(params[:id])
    @reply_user = @reply.user
    if @reply.user.id = current_user.id
     Reply.find(params[:id]).destroy
     @reply_user.update_attributes(points: @reply_user.points-=20)
     @badge = @reply_user.update_badge(@reply_user.id)
     @reply_user.update_attributes(badge: @badge)
     respond_to do |format|
     format.html {redirect_to @new_thread}
     format.json { render action: 'show', status: :created, location: @reply }
     format.js
     end
    end
  end
  
 
  
  private

  def reply_params
    params.require(:reply).permit(:new_thread_id, :content, :user_id)
  end
   
  def find_new_thread
    if params[:new_thread_id]
      @new_thread = NewThread.friendly.find_by_id(params[:new_thread_id])
    end
  end
end
