# frozen_string_literal: true

module JunoApi
  class Auth
    include HTTParty
    PATH = "/authorization-server/oauth/token"
    base_uri "#{JUNO_AUTH_URL}"
    LIMIT_RATE_TO_RENEW = 90
    SECONDS_TO_WAIT_PROCESSING = 0.5

    attr_reader :access_token, :expires_in, :request_time

    private_class_method :new

    def self.singleton
      wait_until_process_is_done
      check_instance
      @instance
    end

    private

    def self.check_instance
      if @instance.blank? || is_about_to_expire?(@instance)
        @processing = true
        @instance = new
        @processing = false
      end
    end

    def initialize
      auth = process_auth!
      @access_token = auth["access_token"]
      @expires_in = auth["expires_in"]
      @request_time = Time.zone.now
    end

    def proccess_auth!
      body = { grant_type: "client_credentials" }
      response = self.class.post(PATH, headers { "Authorization" => "basic #{auth_token}" }, body: body)
      raise Error.new("Bad Request") if response.code != 200
      respose.parsed_response
    end

    def auth_token
      auth_data = Rails.application.credentials.juno.slice(:client_id, :secret)
      Base64.strict_encode64(auth_data[:client]) + ":" + auth_data[:secret]
    end

    def self.is_about_to_expire?(instance)
      expiration_rate = LIMIT_RATE_TO_RENEW / 100.0
      instance.request_time + instance.expires_in * expiration_rate < Time.zone.now
    end

    def self.wait_until_process_is_done
      while @processing
        sleep SECONDS_TO_WAIT_PROCESSING
      end
    end
  end
end
