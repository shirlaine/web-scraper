class UrlScraperService
  def initialize(url)
    @url = url
     # change this line for different backends
    @backend = StupidBackend.new
    # @backend = CacheBackend.new(20)
    @requester = Requester.new(url)
  end

  def name
    uri = URI(@url)
    uri_parse = uri.to_s.gsub(/[^a-z]/,"-")
    uri_parse
    # string friendly name of the URL
    # www.google.com/something/something --> www-google-com-something-something
    # URI parsing
  end

  def scrape
    content = @backend.find(name)
    if content == nil
      content = @requester.get
      @backend.save(name, content)
    end
    content
  end
end