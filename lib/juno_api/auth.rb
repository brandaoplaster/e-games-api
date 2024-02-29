# frozen_string_literal: true

module JunoApi
  class Auth
    include HTTParty
    PATH = "/authorization-server/oauth/token"
    base_uri "#{JUNO_AUTH_URL}"

    def self.singleton
      check_instance
      @instance
    end

    private

    def self.check_instance
      if @instance.blank?
        @instance = new
      end
    end

    def initialize
      auth = process_auth!
      @access_token = auth["access_token"]
      @expires_in = auth["expires_in"]
      @request_time = Time.zone.now
    end
  end
end
