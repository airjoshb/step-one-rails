xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Go to Step One with Joshua Bradley"
    xml.description "Writing about Training, IBD, Crohn's and Entrepreneurship"
    xml.link posts_url

    @posts.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.shortened_content(400)
        xml.pubDate article.pub_date.to_s
        xml.link post_url(article)
        xml.guid post_url(article)
      end
    end
  end
end