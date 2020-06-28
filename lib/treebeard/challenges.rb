module Treebeard
  class Challenges
    attr_reader :client

    def initialize(client)
      @client = client
    end

		def create_challenge(username)
			client.post("/api/challenge/#{username}", body:{ rated: false })
		end

		def accept_challenge(challenge_id)
			client.post("/api/challenge/#{challenge_id}/accept")
		end

		def decline_challenge(challenge_id)
			client.post("/api/challenge/#{challenge_id}/decline")
		end
	end
end