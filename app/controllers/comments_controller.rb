class CommentsController < ApplicationController
  before_action :set_comment, except: %i[index new create]
  before_action :authenticate_user!, except: %i[index show votes]
  before_action :set_commentable, only: %i[index new]
  before_action :assert_mutable, only: %i[edit update destroy]

  # GET /comments or /comments.json
  def index
    @page_size = 16
    @offset = params[:offset]&.to_i || 0
    @comments = Comment
                .order(created_at: :desc)
                .where(commentable_id: @commentable_id, commentable_type: @commentable_type)
                .limit(@page_size)
                .offset(@page_size * @offset)
                .includes(:user, :votes_for)
                .with_rich_text_content
    @has_more_comments = @comments.length == @page_size
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
    @comment.commentable_id = @commentable_id
    @comment.commentable_type = @commentable_type
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def votes
    vote_type = params[:vote_type]
    return if vote_type.nil?

    if vote_type == 'like'
      @comment.undisliked_by current_user if current_user.disliked? @comment
      if current_user.liked? @comment
        @comment.unliked_by current_user
      else
        @comment.liked_by current_user
      end
    elsif vote_type == 'dislike'
      @comment.unliked_by current_user if current_user.liked? @comment
      if current_user.disliked? @comment
        @comment.undisliked_by current_user
      else
        @comment.disliked_by current_user
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Set commentable's id and type
  def set_commentable
    @commentable_id = params[:commentable_id]
    @commentable_type = params[:commentable_type]
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment)
          .permit(:commentable_id, :commentable_type, :content, :status)
          .reverse_merge(user_id: current_user.id)
  end

  def assert_mutable
    redirect_to @comment unless @comment.mutable_to? current_user
  end
end
