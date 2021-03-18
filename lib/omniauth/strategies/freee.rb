# coding: utf-8
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Freee < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.freee.co.jp',
        :authorize_url => 'https://accounts.secure.freee.co.jp/public_api/authorize',
        :token_url => 'https://accounts.secure.freee.co.jp/public_api/token'
      }

      uid { raw_info['user']['email'].to_s }

      info do
        {
          'nickname' => raw_info['user']['display_name'],
          'email' => raw_info['user']['email'],
          'name' => raw_info['user']['display_name'],
          'first_name' => raw_info['user']['first_name'],
          'last_name' => raw_info['user']['last_name'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get('/api/1/users/me?companies=true').parsed
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'freee', 'Freee'
