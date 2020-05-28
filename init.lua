minetest.register_privilege("resize", "player can use /size command")



--change the size of a player
minetest.register_chatcommand("resize", {
	params = "<player> <size>",
	description = "change size of specified <player>",
	privs = {size=true},
  func = function(name, params)
		local player, realsize = unpack(params:split(" "))

		
		local pname = player
		if not realsize then
			realsize = 2
		end
		local size = realsize/0.9/2
		--check on that a name has been inputed
		if not pname then
			return false, "please enter a player name"
		end

		--creates an object reference
    local player = minetest.get_player_by_name(pname)

		--checks to make sure player exists
		if not player then
			return false, "please enter a valid player name"
		end

		--runs only if the player exists
    if player then
			--code that changes all the players settings
		player:set_properties({
	        visual_size = {x = size, y = size, z = size},
	        collisionbox = {-size / 3, 0, -size / 3, size / 3, realsize, size / 3},
	        selectionbox = {-size / 3, 0, -size / 3, size / 3, realsize, size / 3},
			eye_height = realsize* 0.8,
        })
        player:set_eye_offset({x=0,y=0,z=realsize},{x=0,y=0,z=0})
        player:set_physics_override({
        	speed = realsize,
        	jump = realsize,
        	gravity = realsize
      	})
        --player:step_height = realsize/2
			--returns info to the user that intiated the command
			return true, pname .. " has been successfully resized"
    end
  end,
})

function minetest.delay_coro(func)
    local co = coroutine.create(func)
    local function resume()
        local n = coroutine.resume(co)
        if n then return minetest.after(n, resume) end
    end
    resume(co)
end