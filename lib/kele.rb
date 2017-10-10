require 'HTTParty'
require 'pp'
require 'json'

class Kele
    include HTTParty

    def initialize(email, password)
        @email = email
        @password = password
        @base_uri = 'https://www.bloc.io/api/v1'
        @user_auth = self.class.post(@base_uri + '/sessions', body: { "email": @email, "password": @password })["auth_token"]
    end

    def get_me
        response = self.class.get(@base_uri + '/users/me', headers: { "authorization" => @user_auth })
        JSON.parse(response.body)
    end
end
