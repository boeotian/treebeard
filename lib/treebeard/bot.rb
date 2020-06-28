module Treebeard
  class Bot
    attr_reader :client

    def initialize(client)
      @client = client
    end

		def stream_incoming_events()
			streamed = []
			client.get("/api/stream/event") do |req|
				req.options.on_data = Proc.new do |chunk|
					streamed << chunk
				end
			end
			streamed.join
		end

		def stream_game_state(game_id)
			streamed = []
			client.get("/api/bot/game/stream/#{game_id}") do |req|
				req.options.on_data = Proc.new do |chunk|
					streamed << chunk
				end
			end
			streamed.join
		end

		def upgrade_to_bot
			client.post("/api/bot/account/upgrade")
		end

		def make_bot_move(game_id, move)
			client.post("/api/bot/game/#{game_id}/move/#{move}")
		end

		def write_in_chat(game_id, message)
			client.post("/api/bot/game/#{game_id}/chat", body: {room: "player", text: message})
		end

		def abort_game(game_id)
			client.post("/api/bot/board/game/#{game_id}/abort")
		end

		def resign_game(game_id)
			client.post("/api/bot/board/game/#{game_id}/resign")
		end
	end
end