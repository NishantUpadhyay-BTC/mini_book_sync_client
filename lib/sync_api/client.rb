module SyncApi

  HEADERS = {
      "X-HTTP_AUTHORIZATION" => "Token token=fake_token"
  }

  class BookingsError < StandardError; end
  class UnAuthorizeAccessError < StandardError
    def initialize(message=nil)
      if message
        super
      else
        super('Sorry, but you do not have permission to access that.')
      end
    end
  end

  class Client
    include HTTParty
    extend SyncApi::RentalApi
    format :json
    base_uri ENV['BASE_URI']
    headers HEADERS
    default_timeout 300

    def self.send_http_request(url_link, method, parameters)
      binding.pry
      begin
        response = send(method, url_link, query: parameters)
        response_code = response.code.to_s
        case response_code
        when /^2\d\d$/
          response
        when '401'
          raise SyncApi::UnAuthorizeAccessError
        when '500'
          raise StandardError.new(prepare_reponse_message(response['error']))
        else
          raise SyncApi::BookingsError.new(prepare_reponse_message(response['error']))
        end
      rescue Net::ReadTimeout => e
        raise StandardError.new('Server is unable to respond at this time. Please try again or contact Breitenbush Office for more details.')
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
        puts "ERROR::BlissOffice::Client:: #{e.message} ===> #{e.class}"
        raise StandardError.new(e.message)
      end
    end

    def self.prepare_reponse_message(response_error)
      if response_error.is_a? Array
        response_error.join(', ')
      elsif response_error.is_a?String
        response_error
      end
    end
  end
end
