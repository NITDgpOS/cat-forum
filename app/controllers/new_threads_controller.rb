class NewThreadsController < ApplicationController
  before_action :friendly_url, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :list, :search, :show]
  authorize_resource

  def index
    list
    render('list')
  end
  
  def list
    @new_threads = NewThread.paginate(:page => params[:page], :per_page => 10).order('id DESC')

  end

  def search
    #@new_threads = NewThread.search ThinkingSphinx::Query.escape(params[:search])
    @new_threads = NewThread.text_search(params[:query]).paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show 
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the new_thread_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != new_thread_path(@new_thread)
      return redirect_to @new_thread, status: :moved_permanently
    end
  end

  # GET /posts/new
  def new
    @new_thread = NewThread.new
  end

  # GET /posts/1/edit

  # POST /posts
  # POST /posts.json
  def create
    @new_thread = NewThread.new(new_thread_params)

    respond_to do |format|
      if @new_thread.save
        format.html { redirect_to @new_thread, notice: 'New thread was successfully created.' }
        format.json { render action: 'show', status: :created, location: @new_thread }
      else
        format.html { render action: 'new' }
        format.json { render json: @new_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @new_thread.update(new_thread_params)
        format.html { redirect_to @new_thread, notice: 'New thread was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @new_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @thread_user = @new_thread.user
    @new_thread.destroy
    @thread_user.update_attributes(points: @thread_user.points-=20)
    @badge = @thread_user.update_badge(@thread_user.id)
    @thread_user.update_attributes(badge: @badge)
    respond_to do |format|
      format.html { redirect_to new_threads_url }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
 
  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def new_thread_params
      params.require(:new_thread).permit(:title, :description, :user_id)
    end

    def friendly_url
      @new_thread = NewThread.friendly.find(params[:id])
    end

end
