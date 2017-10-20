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
        @enrollment_id = response["current_enrollment"]["id"]
        JSON.parse(response.body)
    end

    def get_mentor_availability(mentor_id)
        response = self.class.get(@base_uri + "/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @user_auth })
        JSON.parse(response.body)
    end

    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
        return "Error: enrollment_id is not defined. Use the #get_me method." unless defined? @enrollment_id
        response = self.class.post(@base_uri + '/checkpoint_submissions', headers: { "authorization" => @user_auth },
            body: {
                "assignment_branch": assignment_branch,
                "assignment_commit_link": assignment_commit_link,
                "checkpoint_id": checkpoint_id,
                "comment": comment,
                "enrollment_id": @enrollment_id
            })
    end
end
