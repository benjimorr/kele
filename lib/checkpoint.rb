module Checkpoint
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

    def update_submission(submission_id, checkpoint_id, assignment_branch, assignment_commit_link, comment)
        return "Error: enrollment_id is not defined. Use the #get_me method." unless defined? @enrollment_id
        response = self.class.put(@base_uri + "/checkpoint_submissions/#{submission_id}", headers: { "authorization" => @user_auth },
            body: {
                "assignment_branch": assignment_branch,
                "assignment_commit_link": assignment_commit_link,
                "checkpoint_id": checkpoint_id,
                "comment": comment,
                "enrollment_id": @enrollment_id
            })
    end
end
