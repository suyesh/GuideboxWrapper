require 'json'
require 'open-uri'

module GuideboxWrapper
  class Client
    def query(url)
      JSON.parse(open(url).read)
    end
  end
  class GuideboxApi
    attr_reader :region, :base_url, :client
    def initialize(key, region)
      @key = key
      @region = region
      @base_url = "http://api-public.guidebox.com/v1.43/#{region}/#{key}"
      @client = Client.new
    end

    def quota
      url = @base_url + "/quota"
      results = @client.query(url)
      results["monthly_quota"]["current"]
    end

  end
end