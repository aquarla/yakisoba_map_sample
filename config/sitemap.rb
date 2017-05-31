# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://yakisoba-map.jp"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  Restaurant.find_each do |restaurant|
    add restaurant_path(restaurant), :lastmod => restaurant.updated_at
  end

  Prefecture.find_each do |prefecture|
    if prefecture.restaurants.present?
      add map_area_path(prefecture.code), :lastmod => prefecture.restaurants.last.updated_at
    end
  end
end
