class SitemapController < ApplicationController
  layout nil

  def index
    @all_posts = Post.all
    @posts = @all_posts.only_parents
    @products = Product.all
    headers["Content-Type"] = "text/xml"
    respond_to do |format|
      format.xml { render :layout => false }
    end
  end
end
