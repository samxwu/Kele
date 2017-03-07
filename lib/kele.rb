require 'httparty'

class Kele
    include HTTParty
    base_uri "https://www.bloc.io/api/v1/sessions"
    
    def initialize(email, password)
         response = self.class.post(self.class.base_uri, body: {"email": email, "password": password})
         errorHandler(response.code) 
         @auth_token = response['auth_token']
    end     
    
    
    def errorHandler(code)
        raise AuthenticationFailError if code == 401
        rescue
            puts "AuthenticationFailError: Invalid email or password" 
    end
end
