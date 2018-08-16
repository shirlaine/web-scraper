class CacheBackendService 
  def initialize(ttl)
    @ttl = ttl
  end

  def find(name)
    return nil if Dir["./#{name}.txt"].empty? #check if file exist if not, return nil
    
    time_stamp = File.open("./#{name}.txt").read.lines.first.delete("\n").to_i #timestamp saved in file
    time_now = Time.now.to_i
    
    if time_now - time_stamp > @ttl # if longer than ttl, fetch again
      puts "Fetching content again"
      nil
    else
       puts "Same Content. Wait #{@ttl} seconds to refresh. It has been #{(time_now-time_stamp)} seconds."
      content= File.read("./#{name}.txt") 
      content
    end
  end

  def save(name, response) 
    time_stamp = Time.now.to_i
    puts time_stamp
    File.write("./#{name}.txt", "#{time_stamp}\n#{response} ") # save timestamp in first line of reponse
  end
end