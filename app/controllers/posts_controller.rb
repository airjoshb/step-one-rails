class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    if params[:category]
      @category = Category.find_by_slug(params[:category])
      children = Post.where(category_id: @category.children.pluck(:id))
      parent = @category.posts.published.present
      @all_posts = children + parent
      @posts = @all_posts[1..8].where("posts.pub_date <= ?", Date.today)
      @first_post = @all_posts.first
      @more = @all_posts.flatten - @posts.flatten - [@first_post] unless @all_posts.empty?
    else
      @all_posts = Post.published.present.not_updates
      @posts = @all_posts.only_parents.offset(1).limit(8)
      @more = @all_posts.only_parents.offset(10)
      @first_post = @all_posts.only_parents.first
    end
  end

  def feed
    @posts = Post.only_parents
    respond_to do |format|
      format.rss { render layout: false }
    end
  end

  def show

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :image, :markdown, :turbo_frame)
  end

end
