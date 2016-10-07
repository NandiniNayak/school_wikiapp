class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  # before_action :set_subject,only: :index

  # GET /posts
  # GET /posts.json

  def vote
    case current_user.voted_as_when_voted_for(@post)
      when nil
        @post.upvote_by current_user
      when true
        @post.unvote_by current_user
        # unvote removes the vote downvote decreases the score--> nandini
      when false
        @post.upvote_by current_user
    else
    end
    redirect_to post_path
    # Jamie : This needs to be updated, refresh required to show changes
    #  however posts_path redirects to posts page which is currently empty
    #  as the post are listed specific to the subject
  end

  def index
    # @posts = Post.all
    @posts = Post.where(subject:params[:subject_id])
    # @posts = @subject.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id if current_user
    @post.approved = false
    # @post.subject_id = @subject.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    # def set_subject
    #   @subject = Subject.find(params[:subject_id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :approved, :subject_id, :user_id,:image)
    end
end
