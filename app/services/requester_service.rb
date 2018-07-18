require 'net/http'

class RequesterService
  ## call this service to get the response
  def initialize(url)
    @url = url
  end

  def call
    uri = URI(@url)
    content = Net::HTTP.get(uri)
    content
  end
end