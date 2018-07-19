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

  ## question
  #     ## how to catch error here if flash/ redirect doesn't work?
  # def get
  #   uri = URI(@url)
  #   begin
  #     @response = Net::HTTP.get(uri)
  #   rescue Timeout::Error, Errno::EINVAL, Errno::ECONNREFUSED, Errno::ECONNRESET, EOFError,
  #     Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
  #     raise StandardError
  #   end
  #   @response.encode('UTF-8', invalid: :replace, undef: :replace)
  # end
end