require 'rubygems'


require 'hpricot_scrub'
require 'cgi'
module Fetch
  module HtmlUtility
    def HtmlUtility.remove_all_tags(html)
      HtmlUtility.sanitize_html(html,[])
    end

    def HtmlUtility.sanitize_html(html,allowed_tags=nil,remove_tags=nil)
      return "" unless html
      return "" if html.empty?
      config={
        :allow_tags => allowed_tags || ['b','i','p','blockquote','em','li','ul','ol'],
        :remove_tags =>remove_tags || ['form', 'script','iframe']
        
      }

      ##############################
      
      page = Hpricot(html)  
      
      page.scrub(config)
      page.to_s.utf_or_die!.gsub(/\n+/,"\n")      
      
      
    end  
  end


end
