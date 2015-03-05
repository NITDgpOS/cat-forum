class NewThreadFlagsController < ApplicationController
  # before_action :set_new_thread_flag, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  
  # GET /reply_flags
  # GET /reply_flags.json
  def index
    @new_threads = NewThread.all
  end

  # GET /reply_flags/1
  # GET /reply_flags/1.json
  def show
  end

  # GET /reply_flags/new
  def new
    @new_thread_flag = NewThreadFlag.new
  end

  # GET /reply_flags/1/edit
  def edit
  end

  # POST /new_thread_flags
  # POST /new_thread_flags.json
  def create
    @user = User.find(current_user.id)
    @new_thread = NewThread.find(params[:new_thread_id])
    @new_thread_flag = @user.add_new_thread_flag(@new_thread.id)

    respond_to do |format|
      if @new_thread_flag.save
        format.html { redirect_to @new_thread_flag, :only_path => true, notice: 'New thread flag was successfully created.' }
        format.json { render :show, status: :created, location: @new_thread_flag }
        format.js
      else
        format.html { render :new }
        format.json { render json: @new_thread_flag.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    @new_thread = NewThread.find(params[:id])
     NewThread.find(params[:id]).destroy
     respond_to do |format|
     format.html {redirect_to(:action => 'index', :controller => 'flags')}
      format.json { render action: 'index', status: :created, location: @new_thread_flag }
     format.js
     end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_thread_flag
      @new_thread_flag = NewThreadFlag.find(params[:id])
    end

    
end
