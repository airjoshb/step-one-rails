class MainController < ApplicationController

  def index
    @page = Page.find_by_slug("home")
    @posts = Post.recent
    @artifact = Artifact.find_by_slug("crohn-s-disease-aip-cookbook") 
    @about = Artifact.find_by_slug("about-joshua") 
    render layout: 'main'
  end
end
