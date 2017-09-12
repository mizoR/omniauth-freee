require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Freee < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.freee.co.jp',
        :authorize_url => 'https://secure.freee.co.jp/oauth/authorize',
        :token_url => 'https://api.freee.co.jp/oauth/token'
      }

      def request_phase
        super
      end

      def callback_phase
        super
      end      

      uid { raw_info['email'].to_s }

      info do
        {
          'nickname' => raw_info['display_name'],
          'email' => raw_info['email'],
          'name' => raw_info['display_name'],
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get('users/me').parsed
      end

      # def callback_url
      #   full_host + script_name + callback_path
      # end
    end
  end
end

OmniAuth.config.add_camelization 'freee', 'Freee'
