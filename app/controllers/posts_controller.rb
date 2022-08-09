class PostsController < ApplicationController
  before_action :set_post, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show votes]
  before_action :assert_visible, except: %i[index new create]
  before_action :assert_mutable, only: %i[edit update destroy]
  before_action :assert_votable, only: %i[like dislike]

  # GET /posts or /posts.json
  def index
    @page_size = 16
    @offset = params[:offset]&.to_i || 0
    @posts = Post.order(created_at: :desc)
                 .limit(@page_size)
                 .offset(@page_size * @offset)
                 .includes(:user, :tags, :votes_for)
                 .with_rich_text_content
                 .select { |post| post.visible_to? current_user }
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Changes of the post's content from recent to old
  def changes
    @changes = @post.content.versions[1..].reverse
  end

  def votes; end

  def like
    @post.undisliked_by current_user if current_user.disliked? @post
    if current_user.liked? @post
      @post.unliked_by current_user
    else
      @post.liked_by current_user
    end
    redirect_to @post.votes_path
  end

  def dislike
    @post.unliked_by current_user if current_user.liked? @post
    if current_user.disliked? @post
      @post.undisliked_by current_user
    else
      @post.disliked_by current_user
    end
    redirect_to @post.votes_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :status, :tag_list).merge(user_id: current_user.id)
  end

  def assert_visible
    redirect_to '/posts' unless @post.visible_to? current_user
  end

  def assert_votable
    # TODO: decide based on user level
  end

  def assert_mutable
    redirect_to '/posts' unless @post.mutable_to? current_user
  end
end
