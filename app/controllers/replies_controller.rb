class RepliesController < ApplicationController
  before_filter :find_new_thread
  before_action :authenticate_user!, except: [:index, :list, :show]
  load_and_authorize_resource :reply, through: :new_thread

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
  end

  def new
  end

  def create
    @user = @new_thread.user

    respond_to do |format|
      if @reply.save
        if current_user != @user
          @user.update_attributes(points: @user.points += 5)
          @badge = @user.update_badge(@user.id)
          @user.update_attributes(badge: @badge)
        end
        @reply.create_activity :create,
                               owner: current_user,
                               recipient: @new_thread.user
        format.html do
          redirect_to @new_thread,
                      notice: 'Reply was successfully created.'
        end
        format.json do
          render action: 'show',
                 status: :created,
                 location: @reply
        end
        format.js
      else
        format.html { render action: 'new' }
        format.json do
          render json: @reply.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html do
          redirect_to @new_thread,
                      notice: 'Reply was successfully updated.'
        end
        format.json { respond_with_bip(@reply) }
      else
        format.html { render action: 'edit' }
        format.json do
          render json: @reply.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def delete
  end

  def destroy
    @reply_user = @reply.user
    if @reply.user.id = current_user.id
      Reply.find(params[:id]).destroy
      @reply_user.update_attributes(points: @reply_user.points -= 20)
      @badge = @reply_user.update_badge(@reply_user.id)
      @reply_user.update_attributes(badge: @badge)
      respond_to do |format|
        format.html { redirect_to @new_thread }
        format.json do
          render action: 'show',
                 status: :created,
                 location: @reply
        end
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
      @new_thread = NewThread.friendly.find(params[:new_thread_id])
    end
  end
end
