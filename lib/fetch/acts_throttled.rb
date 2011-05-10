module Fetch
  module ActsThrottled

    DEFAULT_THROTTLE_BUCKET_SIZE=4.0
    DEFAULT_MAX_FETCHES_PER_SECOND=1.0
    

    def apply_throttler_options(options)
      @throttle_bucket_size=options[:throttle_bucket_size] if options.has_key? :throttle_bucket_size
      @max_fetches_per_second=options[:max_fetches_per_second] if options.has_key? :max_fetches_per_second
    end
    def fetched_times
      @fetched_times ||=[]
    end

    def bucket_period
      @bucket_period || recalculate
    end
    def recalculate
      @bucket_period = (1.0/max_fetches_per_second) * throttle_bucket_size
    end

    def throttle_bucket_size
      @throttle_bucket_size || DEFAULT_THROTTLE_BUCKET_SIZE
    end
    def throttle_bucket_size=(val)
      @throttle_bucket_size=val
      recalculate
    end
    
    def max_fetches_per_second
      @max_fetches_per_second || DEFAULT_MAX_FETCHES_PER_SECOND
    end
    def max_fetches_per_second=(val)
      @max_fetches_per_second=val
      recalculate
    end    

    def age(time_stamp)
      return Time.now-time_stamp
    end

    def bucket_head_age
      return 0.0 if fetched_times.empty?

      age(fetched_times[0])
    end
    def bucket_head
      return nil if fetched_times.empty?
      return fetched_times[0]
    end
    def trim_bucket
      while bucket_head_age >  bucket_period
        fetched_times.shift
      end

      return bucket_head_age
    end
    def bucket_count
      trim_bucket
      fetched_times.length
    end
    def enforce_delay

#      puts "bucket count:#{bucket_count}/#{throttle_bucket_size}"
      while bucket_count>=throttle_bucket_size
        sleep_span=bucket_period-bucket_head_age+0.01
        sleep sleep_span
      end

      fetched_times << Time.now

      yield if block_given?
    end
    
  end
end
