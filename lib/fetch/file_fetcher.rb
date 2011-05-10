module Fetch
  class FileFetcher
    include ActsAsFetcher
    
    def initialize(filepath=filepath,options={})

      options[:fetch_base_url]=filepath
      setup_fetcher(options)
    end
    def self.fetch(url,options={})
      File.open(url ).read
      
    end

  end

end
