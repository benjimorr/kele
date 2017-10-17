module Messages
    def get_messages(page = nil)
        response = nil
        if page
            response = self.class.get(@base_uri + '/message_threads', headers: { "authorization" => @user_auth }, body: { "page": page })
        else
            response = self.class.get(@base_uri + '/message_threads', headers: { "authorization" => @user_auth })
        end
        JSON.parse(response.body)
    end

    def create_message(recipient_id, token = nil, subject, message)
        body = nil
        if token
            body = {
                "sender": @email,
                "recipient_id": recipient_id,
                "token": token,
                "subject": subject,
                "stripped-text": message
            }
        else
            body = {
                "sender": @email,
                "recipient_id": recipient_id,
                "subject": subject,
                "stripped-text": message
            }
        end
        response = self.class.post(@base_uri + '/messages', headers: { "authorization" => @user_auth }, body: body)
    end
end
