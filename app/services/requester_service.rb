require 'net/http'

class RequesterService
  ## call this service to get the response
  def initialize(url)
    @url = url
  end

  def get
    uri = URI(@url)
    @response = Net::HTTP.get(uri)
    @response.encode('UTF-8', invalid: :replace, undef: :replace)
  end
end