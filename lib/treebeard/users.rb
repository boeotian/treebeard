module Treebeard
  class Users
    attr_reader :client

    def initialize(client)
      @client = client
    end

		def get_user_status(users)
      client.get("/api/users/status", body: { ids: users.join(",") })
		end
		
		def get_top_10_players
      client.get("/player")
		end
		
		# nb[1..200], perfType{ultraBullet bullet blitz rapid classical chess960 crazyhouse antichess atomic horde kingOfTheHill racingKings threeCheck}
		def get_top_players_of(nb, perf_type)
			client.get("/player/top/#{nb}/#{perf_type}")
		end

		def get_user(username)
			client.get("/api/user/#{username}")
		end

		# entryFormat[year,month,day,rating], January=0
		def get_user_rating_history(username)
			client.get("/api/user/#{username}/rating-history")
		end

		def get_user_activity(username)
			client.get("/api/user/#{username}/activity")
		end

		def get_puzzle_activity
			client.get("/api/user/puzzle-activity")
		end

		def get_users_by_id()
			client.post("/api/users", body: users.join(","))
		end

		def get_team_members(team_id)
			client.get("/api/team/#{team_id}/users")
		end

		def get_live_streamers
			client.get("/streamer/live")
		end
  end
end