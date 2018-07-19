class StupidBackendService
  def initialize
  end

  def find(name)
    if Dir["./#{name}.*"].empty?
      nil
    else 
      content= File.read("./#{name}.txt") 
      content
    end
  end

  def save(name, response)
    File.write("./#{name}.txt", "#{response}")
  end
end