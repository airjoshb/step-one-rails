class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    if params[:category]
      @category = Category.find_by_slug(params[:category])
      children = Post.where(category_id: @category.children.pluck(:id))
      parent = @category.posts
      @all_posts = children + parent
      @posts = @all_posts[1..7]
      @first_post = @all_posts.first
      @more = @all_posts.flatten - @posts.flatten - [@first_post]
    else
      @all_posts = Post.not_updates
      @posts = @all_posts.only_parents[1..7]
      @more = Post.only_parents.offset(8)
      @first_post = Post.only_parents.first
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
