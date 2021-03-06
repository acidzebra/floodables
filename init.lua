floodables = {
  { group = "torch", drop = "default:torch", sound = "floodables_torch", gain = 0.8 },
  { group = "flora", erode = true},
  { group = "wheat", erode = true },
  { name = "default:junglegrass", erode = true},
  { group = "grass", erode = true },
  { group = "dry_grass", erode = true },
  { name = "default:dirt_with_grass", erode = true },
  { group = "sapling", erode = true },
  { group = "flora", erode = true },
  { group = "flower", erode = true },
  { name = "default:dirt_with_dry_grass", erode = true },
  { name = "default:dirt", erode = true },
  { name = "default:dirt_with_rainforest_litter", erode = true },
  { name = "default:dirt_with_coniferous_litter", erode = true },
  { name = "ethereal:bamboo_dirt", erode = true },
  { name = "ethereal:grove_dirt", erode = true },
  { name = "ethereal:prairie_dirt", erode = true },
  { name = "aotearoa:dirt_with_moss", erode = true },
  { name = "default:silver_sand", erode = true },
  { name = "aotearoa:forest_peat", erode = true },
  { name = "aotearoa:dirt_with_dark_litter", erode = true },
  { name = "aotearoa:restiad_peat", erode = true },
  { name = "aotearoa:peat", erode = true },
}

  --{ group = "wood", erode = true },
  --{ group = "tree", erode = true },
   --{ group = "soil", erode = true },  this causes massive lag for me 
for _,c in ipairs(floodables) do
  if c.name ~=nil then
    minetest.override_item(c.name, {
      floodable = true,
      on_flood = function(pos, oldnode, newnode)
        --minetest.remove_node(pos)
		if pos.y > 1 then
		minetest.set_node(pos, {name="air"})
		end
        if c.sound ~= nil then
          minetest.sound_play({ name = c.sound, gain = c.gain }, { pos = pos, max_hear_distance = 8 })
        end
        if c.drop == nil or c.drop ~= false then c.drop = c.name end
        if c.erode == false then
            minetest.add_item(pos, {name = c.drop})
		end
        if c.erode == true then
          --minetest.remove_node( { x = pos.x, y = pos.y-1, z = pos.z } )
		  minetest.set_node({ x = pos.x, y = pos.y-1, z = pos.z }, {name="air"})
		  --minetest.set_node({ x = pos.x, y = pos.y, z = pos.z }, {name="air"})
		  --minetest.set_node({ x = pos.x, y = pos.y+1, z = pos.z }, {name="air"})
        end
      end
    })
  elseif c.group ~=nil then
    for _,v in pairs(minetest.registered_nodes) do
    	if minetest.get_item_group(v.name, c.group) ~= 0 then
        minetest.override_item(v.name, {
          floodable = true,
          on_flood = function(pos, oldnode, newnode)
            --minetest.remove_node(pos)
			if pos.y > 1 then
			 minetest.set_node(pos, {name="air"})
			end
            if c.sound ~= nil then
              minetest.sound_play({ name = c.sound, gain = c.gain }, { pos = pos, max_hear_distance = 8 })
            end
            if c.drop == nil or c.drop == true then c.drop = v.name end
			if c.erode == false then
              minetest.add_item(pos, {name = c.drop})
			end
            if c.erode == true then
              --minetest.remove_node( { x = pos.x, y = pos.y-1, z = pos.z } )
			  minetest.set_node({ x = pos.x, y = pos.y-1, z = pos.z }, {name="air"})
			  --minetest.set_node({ x = pos.x, y = pos.y, z = pos.z }, {name="air"})
			  --minetest.set_node({ x = pos.x, y = pos.y+1, z = pos.z }, {name="air"})
            end
          end
        })
    	end
    end
  end
end
