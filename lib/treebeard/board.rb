module Treebeard
  class Board
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

		def create_seek()
			streamed = []
			client.get("/api/board/seek") do |req|
				req.options.on_data = Proc.new do |chunk|
					streamed << chunk
				end
			end
			streamed.join
		end

		def stream_game_state(game_id)
			streamed = []
			client.get("/api/board/game/stream/#{game_id}") do |req|
				req.options.on_data = Proc.new do |chunk|
					streamed << chunk
				end
			end
			streamed.join
		end

		def make_board_move(game_id, move)
			client.post("/api/board/game/#{game_id}/move/#{move}")
		end

		# TODO: Make room "spectator" or "player"
		def write_in_chat(game_id, message)
			client.post("/api/board/game/#{game_id}/chat", body: {room: "player", text: message})
		end

		def abort_game(game_id)
			client.post("/api/board/game/#{game_id}/abort")
		end

		def resign_game(game_id)
			client.post("/api/board/game/#{game_id}/resign")
		end

		def handle_draw_offer(game_id, accept_draw)
			client.post("/api/board/game/#{game_id}/draw/#{accept_draw}")
		end
  end
end