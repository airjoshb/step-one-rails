class MainController < ApplicationController

  def index
    @page = Page.find_by_slug("home")
    @posts = Post.joins(:category).where.not(category: {name:  "Update"})
    @updates = Post.joins(:category).where(category: {name:  "Update"})
    @artifact = Artifact.find_by_slug("crohn-s-disease-aip-cookbook") 
    render layout: 'main'
  end
end
