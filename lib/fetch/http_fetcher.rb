require 'open-uri'

module Fetch
  class HttpFetcher
    include Fetch::ActsAsFetcher
    
    def initialize(options={})
      setup_fetcher(options)
    end
    
    # def self.fetch(url)
    #   puts "fetching #{url}"
    #   result =nil  
    #   open(url, "User-Agent" => "cloudwow/automated/spider",
    #        "Referer" => "http://www.globalcoordinate.com/") { |f|
    #     result = f.read
    #   }
    #   return result

    # end

  end

end
