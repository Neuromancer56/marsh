local S = minetest.get_translator("marsh")


------------------------------------------------------------------------
-------------------NODES
------------------------------------------------------------------------
minetest.register_node("marsh:dirt_with_marsh_grass", {
	description = S("Dirt with marsh Grass"),
	tiles = {"swamp_swamp_grass.png", "swamp_mud.png",
		{name = "swamp_mud.png^swamp_swamp_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "marsh:mud",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
		soil = {
			base = "marsh:dirt_with_marsh_grass",
			dry = "farming:soil",
			wet = "farming:soil_wet"
		}
	})

minetest.register_node("marsh:root", {
	description = S("Root"),
	drawtype = "glasslike_framed_optional",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"swamp_root.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marsh:root_with_mud", {
	description = S("Root With Mud"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"swamp_root_with_mud.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marsh:mangrove_wood", {
	description = S("Mangrove Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"swamp_mangrove_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("marsh:mud_brick", {
	description = S("Mud Bricks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"swamp_mud_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, crumbly = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marsh:mud_block", {
	description = S("Mud Blocks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"swamp_mud_block.png"},
	is_ground_content = false,
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "sumpf", gain = 0.4},
	}),
})

minetest.register_node("marsh:mud", {
	description = S("Mud"),
	tiles = {"swamp_mud.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "sumpf", gain = 0.4},
	}),
})

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_pos = player:get_pos()
        local player_node_pos = {
            x = math.floor(player_pos.x + 0.5),
            y = math.floor(player_pos.y + 0.5) - 1,
            z = math.floor(player_pos.z + 0.5) 
        }
        local player_node = minetest.get_node(player_node_pos)
        local player_name = player:get_player_name()

        if player_node.name == "marsh:mud" then
            local two_blocks_down_pos = {x = player_node_pos.x, y = player_node_pos.y - 1, z = player_node_pos.z}
            local two_blocks_down_node = minetest.get_node(two_blocks_down_pos)

            if two_blocks_down_node.name == "marsh:mud" then
                player:set_physics_override({speed = 0.70})
                player:set_physics_override({jump = 0.95})
            else
                player:set_physics_override({speed = 1.0})
                player:set_physics_override({jump = 1.0})
            end
        else
            player:set_physics_override({speed = 1.0})
            player:set_physics_override({jump = 1.0})
        end
    end
end)

minetest.register_node("marsh:mangrove_tree", {
	description = S("Mangrove Tree"),
	tiles = {"swamp_mangrove_tree_top.png", "swamp_mangrove_tree_top.png",
		"swamp_mangrove_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

	minetest.register_node("marsh:mangrove_leaves", {
		description = S("Mangrove Tree Leaves"),
		drawtype = "allfaces_optional",
		tiles = {"swamp_mangrove_leaves.png"},
		waving = 1,
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
		drop = {
			max_items = 1,
			items = {
			    {items = {"marsh:mangrove_sapling"}, rarity = 20},
			    {items = {"marsh:mangrove_leaves"}}
			}
		},
		sounds = default.node_sound_leaves_defaults(),

		after_place_node = default.after_place_leaves,
	})


default.register_fence("marsh:fence_mangrove_wood", {
	description = S("Mangrove Wood Fence"),
	texture = "swamp_fence_mangrove_wood.png",
	inventory_image = "default_fence_overlay.png^swamp_mangrove_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^swamp_mangrove_wood.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "marsh:mangrove_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("marsh:fence_rail_mangrove_wood", {
	description = S("Mangrove Wood Fence Rail"),
	texture = "swawp_fence_rail_mangrove_wood.png",
	inventory_image = "default_fence_rail_overlay.png^swamp_mangrove_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^swamp_mangrove_wood.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "marsh:mangrove_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})

default.register_mesepost("marsh:mese_post_light_mangrove_wood", {
	description = S("Mangrove Wood Mese Post Light"),
	texture = "swamp_fence_mangrove_wood.png",
	material = "marsh:mangrove_wood",
})

minetest.register_node("marsh:mangrove_sapling", {
	description = S("Mangrove Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"swamp_mangrove_sapling.png"},
	inventory_image = "swamp_mangrove_sapling.png",
	wield_image = "swamp_mangrove_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_mangrove_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"marsh:mangrove_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -4, y = 1, z = -4},
			{x = 4, y = 7, z = 4},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

local function grow_new_mangrove_sapling(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(150, 300))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-2, y = pos.y, z = pos.z-3}, minetest.get_modpath("marsh") .. "/schematics/mangrove_tree_1.mts", "0", nil, false)
end

if minetest.get_modpath("bonemeal") then
	bonemeal:add_sapling({
		{"marsh:mangrove_sapling", grow_new_mangrove_sapling, "soil"},
	})
end

if minetest.get_modpath("doors") then
doors.register_fencegate("marsh:gate_mangrove_wood", {
	description = S("Mangrove Wood Fence Gate"),
	texture = "swamp_mangrove_wood.png",
	material = "marsh:mangrove_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})
end

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab("mangrove_wood", "marsh:mangrove_wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"swamp_mangrove_wood.png"},
		S("Mangrove Wood Stair"),
		S("Mangrove Wood Slab"),
		default.node_sound_wood_defaults())
end

doors.register_trapdoor("marsh:mangrove_trapdoor", {
	description = S("Mangrove Trapdoor"),
	inventory_image = "swamp_mangrove_trapdoor.png",
	wield_image = "swamp_mangrove_trapdoor.png",
	tile_front = "swamp_mangrove_trapdoor.png",
	tile_side = "swamp_mangrove_trapdoor_side.png",
	gain_open = 0.06,
	gain_close = 0.13,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
})


doors.register("mangrove_door", {
		tiles = {{ name = "swamp_doors_mangrove_door.png", backface_culling = true }},
		description = S("Mangrove Door"),
		inventory_image = "swamp_doors_item_mangrove.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"marsh:mangrove_wood", "marsh:mangrove_wood"},
			{"marsh:mangrove_wood", "marsh:mangrove_wood"},
			{"marsh:mangrove_wood", "marsh:mangrove_wood"},
		}
})

	minetest.register_node("marsh:muddy_mud", {
		description = S("Muddy Mud"),
		tiles = {"swamp_muddy_mud.png"},
		drop = "marsh:muddy_mud",
		liquid_viscosity = 15,
		liquidtype = "source",
		liquid_alternative_flowing = "marsh:muddy_mud",
		liquid_alternative_source = "marsh:muddy_mud",
		liquid_renewable = false,
		liquid_range = 0,
		drowning = 1,
		walkable = false,
		climbable = false,
		groups = {crumbly = 3, soil = 1, liquid = 3, disable_jump = 1},
	    sounds = default.node_sound_dirt_defaults({
		footstep = {name = "sumpf", gain = 0.4},
	}),
})

minetest.register_node("marsh:glass_bottle_with_water", {
	description = S("Water Glass Bottle"),
	drawtype = "plantlike",
	tiles = {"swamp_water_glass_bottle.png"},
	inventory_image = "swamp_water_glass_bottle.png",
	wield_image = "swamp_water_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
  liquids_pointable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.override_item("vessels:glass_bottle",{
  liquids_pointable = true,
})

minetest.register_on_punchnode(function(pos, node, puncher)
    local player = puncher:get_player_name()
    local itemstack = puncher:get_wielded_item()
    local itemname = itemstack:get_name()

    if itemname == "vessels:glass_bottle" then
        if node.name == "default:water_source" or "default:river_water_source" or "marsh:marsh_water_source" then    
            itemstack:take_item()
            puncher:set_wielded_item(itemstack)
            local inv = puncher:get_inventory()
            if inv:room_for_item("main", "marsh:glass_bottle_with_water") then
                inv:add_item("main", "marsh:glass_bottle_with_water")
            else
                minetest.add_item(pos, "marsh:glass_bottle_with_water")
            end
        end
    end
end)

minetest.register_on_punchnode(function(pos, node, puncher)
    local player = puncher:get_player_name()
    local itemstack = puncher:get_wielded_item()
    local itemname = itemstack:get_name()

    if itemname == "marsh:glass_bottle_with_water" then
        if node.name == "default:water_source" or "default:river_water_source" or "marsh:marsh_water_source" then    
            itemstack:take_item()
            puncher:set_wielded_item(itemstack)
            local inv = puncher:get_inventory()
            if inv:room_for_item("main", "vessels:glass_bottle") then
                inv:add_item("main", "vessels:glass_bottle")
            else
                minetest.add_item(pos, "vessels:glass_bottle")
            end
        end
    end
end)

minetest.register_on_punchnode(function(pos, node, puncher)
    local player = puncher:get_player_name()
    local itemstack = puncher:get_wielded_item()
    local itemname = itemstack:get_name()

    if itemname == "marsh:glass_bottle_with_water" then
        if node.name == "default:dirt" then
            minetest.set_node(pos, {name = "marsh:mud"})     
            itemstack:take_item()
            puncher:set_wielded_item(itemstack)
            local inv = puncher:get_inventory()
            if inv:room_for_item("main", "vessels:glass_bottle") then
                inv:add_item("main", "vessels:glass_bottle")

            else
                minetest.add_item(pos, "vessels:glass_bottle")
            end
        end
    end
end)

	minetest.register_node("marsh:marsh_water_source", {
		description = S("marsh Water Source"),
		drawtype = "liquid",
		tiles = {
			{
				name = "swamp_swamp_water_source_animated.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
			{
				name = "swamp_swamp_water_source_animated.png",
				backface_culling = true,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
		},
		use_texture_alpha = "blend",
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "source",
		liquid_alternative_flowing = "marsh:marsh_water_flowing",
		liquid_alternative_source = "marsh:marsh_water_source",
		liquid_viscosity = 1,
		-- Not renewable to avoid horizontal spread of water sources in sloping
		-- rivers that can cause water to overflow riverbanks and cause floods.
		-- River water source is instead made renewable by the 'force renew'
		-- option used in the 'bucket' mod by the river water bucket.
		liquid_renewable = false,
		liquid_range = 2,
		post_effect_color = {a = 128, r = 30, g = 80, b = 39},
		groups = {water = 3, liquid = 3, cools_lava = 1},
		sounds = default.node_sound_water_defaults(),
	})

	minetest.register_node("marsh:marsh_water_flowing", {
		description = S("marsh Water"),
		drawtype = "flowingliquid",
		tiles = {"swamp_swamp_water.png"},
		special_tiles = {
			{
				name = "swamp_swamp_water_flowing_animated.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.5,
				},
			},
			{
				name = "swamp_swamp_water_flowing_animated.png",
				backface_culling = true,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.5,
				},
			},
		},
		use_texture_alpha = "blend",
		paramtype = "light",
		paramtype2 = "flowingliquid",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "flowing",
		liquid_alternative_flowing = "marsh:marsh_water_flowing",
		liquid_alternative_source = "marsh:marsh_water_source",
		liquid_viscosity = 1,
		liquid_renewable = false,
		liquid_range = 2,
		post_effect_color = {a = 128, r = 30, g = 80, b = 39},
		groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
			cools_lava = 1},
		sounds = default.node_sound_water_defaults(),
	})


	bucket.register_liquid(
		"marsh:marsh_water_source",
		"marsh:marsh_water_flowing",
		"marsh:bucket_marsh_water",
		"swamp_bucket_swamp_water.png",
		("marsh Water Bucket"),
		{tool = 1, water_bucket = 1},
		true
	)

minetest.register_node("marsh:vine", {
	description = S("marsh Vine"),
	drawtype = "signlike",
	tiles = {"swamp_vine.png"},
	inventory_image = "swamp_vine.png",
	wield_image = "swamp_vine.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted"
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults()
})

------------------------------------------------------------------------
-------------------CRAFTS
------------------------------------------------------------------------

minetest.register_craft({
	type = "fuel",
	recipe = "marsh:mangrove_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "marsh:root",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "marsh:root_with_mud",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "marsh:fence_mangrove_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "marsh:fence_rail_mangrove_wood",
	burntime = 4,
})

minetest.register_craft({
	output = "marsh:mangrove_wood 4",
	recipe = {
		{"marsh:mangrove_tree"},
	}
})

minetest.register_craft({
	output = "default:stick 6",
	recipe = {
		{"marsh:root"},
	}
})

minetest.register_craft({
	output = "default:stick 3",
	recipe = {
		{"marsh:root_with_mud"},
	}
})

minetest.register_craft({
	output = "marsh:mud_block",
	recipe = {
		{"marsh:mud", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "marsh:mud_brick",
	recipe = {
		{"marsh:mud_block", "marsh:mud_block",},
		{"marsh:mud_block", "marsh:mud_block"},
	}
})

minetest.register_craft({
	output = "marsh:mangrove_trapdoor 2",
	recipe = {
		{"marsh:mangrove_wood", "marsh:mangrove_wood", "marsh:mangrove_wood"},
		{"marsh:mangrove_wood", "marsh:mangrove_wood", "marsh:mangrove_wood"},
		{"", "", ""},
	}
})

------------------------------------------------------------------------
-------------------LEAFDECAY
------------------------------------------------------------------------

if minetest.get_mapgen_setting("mg_name") == "v6" then
	default.register_leafdecay({
		trunks = {"marsh:mangrove_tree", "marsh:root"},
		leaves = {"marsh:mangrove_leaves", "marsh:vine"},
		radius = 3,
	})
end

default.register_leafdecay({
	trunks = {"marsh:mangrove_tree", "marsh:root"},
	leaves = {"marsh:mangrove_leaves", "marsh:vine"},
	radius = 3,
})

------------------------------------------------------------------------
-------------------MAPGENS
------------------------------------------------------------------------

minetest.register_biome({
    name = "marsh",
    node_top = "marsh:dirt_with_marsh_grass",
    depth_top = 1,
    node_filler = "marsh:mud",
    depth_filler = 3,
    node_riverbed = "marsh:mud",
    depth_riverbed = 2,
    node_dungeon = "marsh:mud_brick",
    node_dungeon_alt = "marsh:mud_block",
    y_max = 2,
    y_min = -20,
    heat_point = 80,
    humidity_point = 98,
})

	minetest.register_biome({
		name = "marsh_ocean",
		node_top = "marsh:mud",
		depth_top = 1,
		node_filler = "marsh:mud",
		depth_filler = 3,
		node_riverbed = "marsh:mud",
		depth_riverbed = 2,
		node_cave_liquid = "marsh:marsh_water_source",
        node_dungeon = "marsh:mud_brick",
        node_dungeon_alt = "marsh:mud_block",
		vertical_blend = 1,
		node_river_water = "marsh:marsh_water_source",
		node_riverbed = "default:gravel",
		y_max = -1,
		y_min = -255,
    heat_point = 80,
    humidity_point = 98,
	})

	minetest.register_biome({
		name = "marsh_under",
		node_cave_liquid = {"marsh:marsh_water_source", "default:lava_source"},
    node_dungeon = "marsh:mud_brick",
    node_dungeon_alt = "marsh:mud_block",
		y_max = -256,
		y_min = -31000,
    heat_point = 80,
    humidity_point = 98,
	})

minetest.register_decoration({
	name = "marsh:root_with_mud",
	deco_type = "simple",
	place_on = {"marsh:dirt_with_marsh_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.5,
		scale = 0.4,
        spread = {x = 50, y = 50, z = 50},
		seed = 21,
		octaves = 2,
		persist = 0.11,
	},
	biomes = {"marsh"},
	height = 1,
	y_min = 1,
	y_max = 31000,
	place_offset_y = -1,
	decoration = "marsh:root_with_mud",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

minetest.register_decoration({
	name = "marsh:muddy_mud",
	deco_type = "simple",
	place_on = {"marsh:root_with_mud"},
	sidelen = 16,
	noise_params = {
		offset = 0.5,
		scale = 0.4,
        spread = {x = 50, y = 50, z = 50},
		seed = 21,
		octaves = 2,
		persist = 0.11,
	},
	biomes = {"marsh"},
	height = 1,
	y_min = 1,
	y_max = 31000,
	place_offset_y = -1,
	decoration = "marsh:muddy_mud",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

minetest.register_decoration({
	name = "marsh:mud",
	deco_type = "simple",
	place_on = {"marsh:dirt_with_marsh_grass", "marsh:root_with_mud"},
	sidelen = 16,
	noise_params = {
		offset = 0.5,
		scale = 0.4,
        spread = {x = 50, y = 50, z = 50},
		seed = 21,
		octaves = 2,
		persist = 0.11,
	},
	biomes = {"marsh"},
	height = 1,
	y_min = 1,
	y_max = 31000,
	place_offset_y = -1,
	decoration = "marsh:mud",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})



minetest.register_decoration({
    name = "marsh:marsh_source_2",
    deco_type = "schematic",
    place_on = {"marsh:dirt_with_marsh_grass", "terraria:root_with_mud"},
    sidelen = 16,
    noise_params = {
        offset = 0.25,
        scale = 0.25,  
        spread = {x = 250, y = 250, z = 250},
        seed = 78,
        octaves = 3,
        persist = 2
    },
    biomes = {"marsh"},
    height = 1,
    y_min = 0,
    y_max = 3,
    place_offset_y = -1,
    schematic = minetest.get_modpath("marsh") .. "/schematics/marsh_source_2.mts",
    flags = "place_center_x, place_center_z, force_placement",
    rotation = "random",
})

minetest.register_decoration({
    name = "marsh:marsh_source_1",
    deco_type = "schematic",
    place_on = {"marsh:dirt_with_marsh_grass", "terraria:root_with_mud"},
    sidelen = 16,
    noise_params = {
        offset = 0.072,
        scale = 0.108,  
        spread = {x = 250, y = 250, z = 250},
        seed = 78,
        octaves = 3,
        persist = 2
    },
    biomes = {"marsh"},
    height = 1,
    y_min = 0,
    y_max = 10,
    place_offset_y = -1,
    schematic = minetest.get_modpath("marsh") .. "/schematics/marsh_source_1.mts",
    flags = "place_center_x, place_center_z, force_placement",
    rotation = "random",
})

minetest.register_decoration({
	deco_type = "simple",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	sidelen = 16,
	fill_ratio = 0.07,
	biomes = {"marsh"},
	decoration = {
		"fireflies:firefly",
	}
})

minetest.register_decoration({
    deco_type = "simple",
        place_on = {"default:water_source", "marsh:marsh_water_source"},
    sidelen = 16,
    fill_ratio = 0.15,
   biomes = {"marsh", "marsh_ocean"},
decoration = "flowers:waterlily_waving",
})
--[[
minetest.register_decoration({
    deco_type = "simple",
        place_on = {"default:water_source", "marsh:marsh_water_source"},
    sidelen = 16,
    fill_ratio = 0.15,
   biomes = {"marsh", "marsh_ocean"},
decoration = "dryplants:reedmace_water_entity",
})
]]
--[[minetest.register_decoration({
	deco_type = "simple",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	sidelen = 16,
	fill_ratio = 0.15,
	biomes = {"marsh"},
	decoration = {
		"default:junglegrass", "default:fern_2", "default:fern_3",
	}
})]]

minetest.register_decoration({
	deco_type = "simple",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	sidelen = 16,
	fill_ratio = 0.15,
	biomes = {"marsh"},
	decoration = {
		"dryplants:juncus",
	}
})

-----------------------------------------------------------------------------------------------
-- GENERATE REEDMACE
-----------------------------------------------------------------------------------------------
-- near water or marsh
biome_lib.register_on_generate({
    surface = {
		"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"
	},
    max_count = 35*100,
    rarity = (101 - 40)/20,
	--rarity = 60,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:water_source","marsh:marsh_water_source", "marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace
)
-- in water
biome_lib.register_on_generate({
    surface = {
		"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"
	},
    max_count = 35*100,
	rarity = (101 - 40)/20,
    --rarity = 35,
    min_elevation = 0, -- a bit below sea level
	max_elevation = 0, -- ""
	near_nodes = {"default:water_source","marsh:marsh_water_source"},
	near_nodes_size = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace_water
)
-- for oases & tropical beaches & tropical marshs
biome_lib.register_on_generate({
    surface = {
		"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"
	},
    max_count = 35*100,
    rarity = (101 - 90)/20,
	--rarity = 10,
    neighbors = {"default:water_source","marsh:marsh_water_source", "marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	ncount = 1,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:water_source","marsh:marsh_water_source", "marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace
)



minetest.register_decoration({
	deco_type = "simple",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
	sidelen = 16,
		y_max = 10,
		y_min = 1,
	fill_ratio = 0.05,
	biomes = {"marsh"},
	decoration = {
		"flowers:mushroom_brown",
	}
})

	--[[minetest.register_decoration({
		name = "marsh:mangrove_tree_1",
		deco_type = "schematic",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
		sidelen = 16,
		noise_params = {
			offset = 0.02,
			scale = 0.005,
			spread = {x = 250, y = 250, z = 250},
			seed = 201,
			octaves = 1,
			persist = 0.11
		},
		biomes = {"marsh"},
		y_max = 10,
		y_min = 1,
		schematic = minetest.get_modpath("marsh") .. "/schematics/mangrove_tree_1.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random"
	})

	minetest.register_decoration({
		name = "marsh:mangrove_tree_2",
		deco_type = "schematic",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
		sidelen = 16,
		noise_params = {
			offset = 0.02,
			scale = 0.005,
			spread = {x = 250, y = 250, z = 250},
			seed = 201,
			octaves = 1,
			persist = 0.11
		},
		biomes = {"marsh"},
		y_max = 10,
		y_min = 1,
		schematic = minetest.get_modpath("marsh") .. "/schematics/mangrove_tree_2.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random"
	})

	minetest.register_decoration({
		name = "marsh:mangrove_tree_3",
		deco_type = "schematic",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
		sidelen = 16,
		noise_params = {
			offset = 0.02,
			scale = 0.005,
			spread = {x = 250, y = 250, z = 250},
			seed = 201,
			octaves = 1,
			persist = 0.11
		},
		biomes = {"marsh"},
		y_max = 10,
		y_min = 1,
		schematic = minetest.get_modpath("marsh") .. "/schematics/mangrove_tree_3.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random"
	})


	minetest.register_decoration({
		name = "marsh:mangrove_tree_1_3",
		deco_type = "schematic",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
		sidelen = 16,
		noise_params = {
			offset = 0.015,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 201,
			octaves = 1,
			persist = 0.11
		},
		biomes = {"marsh"},
		y_max = -1,
		y_min = -1,
		schematic = minetest.get_modpath("marsh") .. "/schematics/mangrove_tree_1_3.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random"
	})

	minetest.register_decoration({
		name = "marsh:mangrove_tree_2_2",
		deco_type = "schematic",
		place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
		sidelen = 16,
		noise_params = {
			offset = 0.015,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 201,
			octaves = 1,
			persist = 0.11
		},
		biomes = {"marsh"},
		y_max = -2,
		y_min = -2,
		schematic = minetest.get_modpath("marsh") .. "/schematics/mangrove_tree_2_2.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random"
	})]]

minetest.register_decoration({
        name = "marsh:mangrove_tree_4",
        deco_type = "schematic",
        place_on = {"marsh:dirt_with_marsh_grass", "marsh:mud", "marsh:root_with_mud"},
        sidelen = 16,
        noise_params = {
            offset = 0.007,
            scale = 0.001,
            spread = {x = 250, y = 250, z = 250},
            seed = 201,
            octaves = 1,
            persist = 0.11
        },
        biomes = {"marsh"},
        y_max = 10,
        y_min = 1,
        schematic = minetest.get_modpath("marsh") .. "/schematics/mang_1_Dying.mts",
        flags = "place_center_x, place_center_z",
        rotation = "random"
    })



------------------------------------------------------------------------
-------------------DUNGEON LOOT
------------------------------------------------------------------------

if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register ({
		{name = "marsh:mud", chance = 0.1, count = {2, 9}},
		{name = "marsh:mangrove_sapling", chance = 0.3, count = {2, 4}},
		{name = "marsh:mud", chance = 0.3, count = {3, 12}},

		{name = "marsh:mangrove_leaves", chance = 0.3, count = {2, 8}},
	})	
end
