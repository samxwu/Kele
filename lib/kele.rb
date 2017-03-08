require 'httparty'
require 'json'

class Kele
    include HTTParty
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
    
    private
    
    def errorHandler(code)
        raise AuthenticationFailError if code == 401
        rescue
            puts "AuthenticationFailError: Invalid email or password" 
    end
end
