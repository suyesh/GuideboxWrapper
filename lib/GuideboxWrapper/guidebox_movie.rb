require 'GuideboxWrapper/query_builders/movie/movie_query_builders'
require 'GuideboxWrapper/movie/movie'

module GuideboxWrapper
  class GuideboxMovie < GuideboxApi
    include MovieQueryBuilders
    # Search for show
    def search_for(name)
      url = build_query(name)
      url += '/fuzzy/web'
      data = @client.query(url)
      sleep(1)
      data["results"]
    end

    # Search by provider
    def search_for_by_provider(name, provider)
      url = build_query(name)
      url += '/fuzzy/' + provider + '/web'
      data = @client.query(url)
      data["results"]
    end

    def search_by_db_id(id, type)
      url = @base_url
      url += "/search/movie/id/"
      case type
      when "themoviedb"
        url += "themoviedb/"
        url += id.to_s
      when "imdb"
        url += "imdb/"
        url += id
      else
        puts "That id type does not exist"
        return
      end
      @client.query(url)
    end

    def show_information(name)
      id = self.search_for(name).first["id"]
      url = @base_url
      url += "/movie/" + id.to_s
      @client.query(url)
    end

    def fetch_movie(name_or_id)
      url = @base_url
      id = set_name_or_id(name_or_id)
      url += "/movie/" + id.to_s 
      results = @client.query(url)
      Movie.new(results)
    end

    def posters(name_or_id)
      url = @base_url
      id = set_name_or_id(name_or_id)
      url += "/movie/" + id.to_s + "/images/posters"
      results = @client.query(url)
      results["results"]["posters"]
    end

    def thumbnail_images(name_or_id)
      url = @base_url
      id = set_name_or_id(name_or_id)
      url += "/movie/" + id.to_s + "/images/thumbnails"
      results = @client.query(url)
      results["results"]["thumbnails"]
    end

    def banner_images(name_or_id)
      url = @base_url
      id = set_name_or_id(name_or_id)
      url += "/movie/" + id.to_s + "/images/banners"
      results = @client.query(url)
      results["results"]["banners"]
    end

    def background_images(name_or_id)
      url = @base_url
      id = set_name_or_id(name_or_id)
      url += "/movie/" + id.to_s + "/images/backgrounds"
      results = @client.query(url)
      results["results"]["backgrounds"]
    end
  end
end