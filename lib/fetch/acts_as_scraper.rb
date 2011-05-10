require 'open-uri'

module Fetch
  module ActsAsScraper

    
    def uri_escape(value)
      URI.escape( value, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")  )
    end

  end
end
