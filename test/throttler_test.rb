require 'test_helper.rb'

class ThrottlerTest < Test::Unit::TestCase

  include Fetch::ActsThrottled
  def test_slow_delay
    apply_throttler_options(:max_fetches_per_second=>0.33333333,:throttle_bucket_size=>1)
    start=Time.now
    4.times do |i|
      enforce_delay{
#        puts "##{i}"
      }
    end
#    puts "total time: #{Time.now-start}"
    assert(Time.now-start>=9.0)
    assert(Time.now-start<9.15)
  end
    
  def test_fast_delay
    apply_throttler_options(:max_fetches_per_second=>10,:throttle_bucket_size=>1)
    start=Time.now
    40.times do |i|
      enforce_delay{
#        puts "##{i}"
      }
    end
#    puts "!!!!!!!!!!!! total time: #{Time.now-start}"
    

    assert(Time.now-start>=4.0)
    assert(Time.now-start<4.5)
  end
    
  def test_fast_delay_with_bucket
    apply_throttler_options(:max_fetches_per_second=>10,:throttle_bucket_size=>10)
    start=Time.now
    40.times do |i|
      enforce_delay{
#        puts "##{i}"
      }
    end
 #   puts "total time: #{Time.now-start}"
    assert(Time.now-start>=3.0)
    assert(Time.now-start<3.5)
  end
    
end
