require 'httparty'
require 'json'
require_relative 'roadmap'

class Kele
    include HTTParty
    include Roadmap
    base_uri "https://www.bloc.io/api/v1"
    
    def initialize(email, password)
         response = self.class.post("/sessions", body: {"email": email, "password": password})
         errorHandler(response.code) 
         @auth_token = response['auth_token']
    end
    
    def get_me
        response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
        parsed_response = JSON.parse(response.body)
    end
    
    def get_mentor_availability(mentor_id)
        #my_info = get_me()
        #mentor_id = my_info['current_enrollment']['mentor_id']
        response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
        parsed_response = JSON.parse(response.body)
    end
    
    def get_messages(page_no = '')
        if page_no == ''
            response = self.class.get("/message_threads", headers: { "authorization" => @auth_token })
        else
            response = self.class.get("/message_threads", headers: { "authorization" => @auth_token }, body: { "page":page_no})
        end
        parsed_response = JSON.parse(response.body)
    end
    
    def create_message(sender, recipient_id, stripped_text, options = {})
        msg_attributes = {
            sender: sender, 
            recipient_id: recipient_id, 
            stripped_text: stripped_text, 
        }
        
        msg_attributes["subject"] = options[:subject] if options[:subject]
        msg_attributes["token"] = options[:token] if options[:token]
        
        response = self.class.post("/messages", headers: { "authorization" => @auth_token }, body: msg_attributes)
    end

    
    private
    
    def errorHandler(code)
        raise AuthenticationFailError if code == 401
        rescue
            puts "AuthenticationFailError: Invalid email or password" 
    end
end
