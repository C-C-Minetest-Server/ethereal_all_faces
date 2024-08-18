-- ethereal_all_faces/init.lua
-- All-faces tree block for Ethereal trees
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

local S = minetest.get_translator("ethereal_all_faces")

for _, orig_name in ipairs({
    "sakura_trunk",
    "willow_trunk",
    "redwood_trunk",
    "frost_tree",
    "yellow_trunk",
    "palm_trunk",
    "banana_trunk",
    "scorched_tree",
    "mushroom_trunk",
    "birch_trunk",
    "olive_trunk",
}) do
    local itemname = "ethereal_all_faces:all_faces_" .. orig_name
    local orig_def = minetest.registered_nodes["ethereal:" .. orig_name]
    local flammable = orig_def.groups and orig_def.groups.flammable or 2
    local def = {
        description = S("All-faces @1", orig_def.description or orig_name),
        tiles = { orig_def.tiles[1] },
        groups = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = flammable },
        sounds = orig_def.sounds,
    }
    minetest.register_node(itemname, def)

    if minetest.global_exists("stairsplus") then
        if stairsplus.api then -- flux
            stairsplus.api.register_all(itemname)
        else                   -- minetest-mods
            stairsplus:register_all(
                "ethereal_all_faces",
                "all_faces_" .. orig_name,
                itemname,
                def)
        end
    end

    minetest.register_craft({
        output = itemname .. " 8",
        recipe = {
            { "ethereal:" .. orig_name, "ethereal:" .. orig_name, "ethereal:" .. orig_name },
            { "ethereal:" .. orig_name, "",                       "ethereal:" .. orig_name },
            { "ethereal:" .. orig_name, "ethereal:" .. orig_name, "ethereal:" .. orig_name }
        }
    })
end
