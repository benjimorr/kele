require 'HTTParty'
require 'pp'

class Kele
    include HTTParty

    def initialize(email, password)
        @email = email
        @password = password
        @base_uri = 'https://www.bloc.io/api/v1'
        @user_auth
    end

    def get_auth
        options = {
            body: {
                "email": @email,
                "password": @password
            }
        }

        response = self.class.post(@base_uri + '/sessions', options)
        @user_auth = response["auth_token"]
    end
end
