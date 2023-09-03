xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Go to Step One with Joshua Bradley"
    xml.description "Passionate about making life better. Writing about training, IBD, Crohn's."
    xml.link posts_url
    xml.language "en-US"
	  xml.updatePeriod "hourly"
	  xml.updateFrequency "1"

    @posts.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.content
        xml.pubDate article.pub_date.to_s
        xml.link post_url(article)
        xml.guid post_url(article)
      end
    end
  end
end