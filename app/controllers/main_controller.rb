class MainController < ApplicationController

  def index
    @page = Page.find_by_slug("home")
    @posts = Post.recent
    feature = Category.find_by_name('feature')
    @artifact = Artifact.where(category_id: feature.id).first
    events = Category.find_by_name('event')
    @events = Artifact.where(category_id: events.id).upcoming
    @about = Artifact.find_by_slug("about-joshua") 
    render layout: 'main'
  end
end
