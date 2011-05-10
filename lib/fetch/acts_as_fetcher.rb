require 'open-uri'

module Fetch
  module ActsAsFetcher



    
    def self.included(base_class)
      
      base_class.class_eval("
    attr_accessor :fetch_base_url
            ")

      base_class.extend(ClassMethods)

    end
    
    #options
    #  :fetch_base_url a prefix prepended to all urls
    # :throttle_bucket_size
    # :max_fetches_per_second
    def setup_fetcher(options={})
      @fetch_base_url = options[:fetch_base_url] || ""

      @fetch_count=0


      @record_directory=options[:record_directory]
      @playback_directory=options[:playback_directory]

      @throttler=options[:throttler] || Nanikore::Throttler.new(options)
    end

    def record_result(url,result)
      if @record_directory
        path=url_to_file_path(url)

        path=@record_directory+"/"+path
        FileUtils.mkdir_p path
        f = File.new(path+"/http_result.txt","w")
        f.write(result) 
        f.close                
      end

    end

    def playback_result(url)
      result=nil
      if @playback_directory


        path=url_to_file_path(url)
        
        path=@playback_directory+"/"+path +"/http_result.txt"
        if File.exist? path
          result=File.open(path,"r").read
        end
        
      end
      return result
    end



    def url_to_file_path(url)
      (@fetch_base_url+url).gsub("http://","").gsub("https://","").gsub("&","/")
    end

    
    def fetch(url,options={})
      @fetch_count=@fetch_count+1

      
      if @playback_directory
        result=playback_result(url)
        return result if result
      end
      
      @throttler.enforce do
        result=self.class.fetch(@fetch_base_url+url,options)
      end
      
      record_result(url,result)
      result
    end
    
    module ClassMethods
      def try_encoding(string,encoding)
        temp=string.clone
        temp.force_encoding(encoding)
        if temp.valid_encoding?
          string.force_encoding(encoding)
          true
        else
          false
        end
      end

      def decode_downloaded_string(data)
        unless try_encoding(data,"UTF-8")

          if try_encoding(data,"iso-8859-1")
            data.encode!("UTF-8")
          else
            data.force_encode("UTF-8")
          end
        end

        raise "fetched text  has unknown encoding.  url: #{url}" unless data.valid_encoding?
      end
      
      def fetch(url,options={})
        unless options[:ignore_robots]

          @@robots ||= Fetch::Robots.new("*")
          unless @@robots.allowed? url
            puts "fetch denied by robots.txt"
            return nil
          end
        end

        result =nil
        begin
          Nanikore::Retry.retryable() do 
            open(url, "User-Agent" => 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
                 "Referer" => "http://www.google.com/search?aq=f&sourceid=chrome&ie=UTF-8&q=#{CGI.escape(url)}") { |f|
              
              if f.content_encoding.include? 'gzip'
                result = Zlib::GzipReader.new(f).read
              else
                result= f.read
              end
            }

            
          end
        rescue Exception => e
          if e.message.match(/404|500|503|502|timed out/)
            puts e.message
            #not found
            result=nil
          else
            raise "Could not download url #{url}.\n Error was #{e.message}"
          end
        end 
        
        if result
          decode_downloaded_string(result)
          
        end
        
        return result
      end
    end
  end


end
