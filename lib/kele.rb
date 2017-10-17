require 'HTTParty'
require 'pp'
require 'json'
require_relative 'roadmap'
require_relative 'messages'

class Kele
    include HTTParty
    include Roadmap
    include Messages

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

    def get_mentor_availability(mentor_id)
        response = self.class.get(@base_uri + "/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @user_auth })
        JSON.parse(response.body)
    end
end
