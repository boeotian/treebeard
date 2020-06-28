module Treebeard
  class Account
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get_profile
      client.get("/api/profile")
		end
		
		def get_email
      client.get("/api/profile/email")
		end
		
		def get_preferences
			client.get("/api/account/preferences")
		end

		def get_kid_mode
			client.get("/api/account/kid")
		end

		def set_kid_mode(mode)
			client.post("/api/profile/kid", body: {v: mode})
		end
  end
end