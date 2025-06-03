class MainController < ApplicationController

  def index
    @page = Page.find_by_slug("home")
    @posts = Post.only_parents.recent
    feature = Category.find_by_name('feature')
    @artifacts = Artifact.where(category_id: feature.id)
    events = Category.find_by_name('event')
    @events = Artifact.where(category_id: events.id).upcoming
    embeds = Category.find_by_name('embeds')
    @embeds = Artifact.where(category_id: embeds.id)
    @about = Artifact.find_by_slug("about-joshua") 
    render layout: 'main'
  end
end
