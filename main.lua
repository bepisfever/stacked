SMODS.current_mod.optional_features = {retrigger_joker = true}
Stacked = SMODS.current_mod
Stacked.effect_per_page = 2
Stacked.stakes_without_curses = {1,2,3}

local hex_ref = HEX
function HEX(hex)
    local hex = (hex and type(hex) == "table" and copy_table(hex)) or hex
    if hex then
        if type(hex) == "table" then
            local concat = table.concat(hex,",")
            local new_hex = {}
            for rgb in concat:gmatch('%d+') do
                table.insert(new_hex, ('%02X'):format(tonumber(rgb)))
            end
            hex = table.concat(new_hex)
        elseif type(hex) == "string" and string.find(hex,",") then
            local new_hex = {}
            for rgb in hex:gmatch('%d+') do
                table.insert(new_hex, ('%02X'):format(tonumber(rgb)))
            end
            hex = table.concat(new_hex)
        end
        if type(hex) == "string" and string.sub(hex,1,1) == "#" then
            hex = string.sub(hex,2,#hex)
        end
    end
    local ret = hex_ref(hex)
    return ret
end

local allFolders = {
    "none", "code"
} --Detects in order, going from left to right.

local allFiles = {
    ["none"] = {},
    ["code"] = {"misc_functions", "extraeffects", "main_functions", "keybinds", "consumables", "vouchers", "hooks"},
} --Same goes with this.

for i = 1,#allFolders do
    if allFolders[i] == "none" then
        for i2 = 1,#allFiles[allFolders[i]] do
            assert(SMODS.load_file(allFiles[allFolders[i]][i2]..'.lua'))()
        end
    else
        for i2 = 1,#allFiles[allFolders[i]] do
            assert(SMODS.load_file(allFolders[i].."/"..allFiles[allFolders[i]][i2]..'.lua'))()
        end
    end
end

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32,
})

SMODS.Gradient{
    key = "cursed",
    colours = {G.C.UI.TEXT_LIGHT, G.C.RED},
    cycle = 7
}

SMODS.Gradient{
    key = "m_a_c",
    colours = {G.C.MULT, G.C.CHIPS},
    cycle = 7
}

SMODS.Gradient{
    key = "rainbow",
    colours = {HEX("#ff0000"), HEX("#ff7b00"), HEX("#fff700"), HEX("#26ff00"), HEX("#00eeff"), HEX("#000dff"), HEX("#ff00cc")},
    cycle = 7
}

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end

    for i,v in pairs(SMODS.Gradients) do
        if string.sub(i,1,5) == "stck_" then
            G.ARGS.LOC_COLOURS[i] = SMODS.Gradients[i]
        end
    end

    return loc_colour_ref(_c, _default)
end

--Reminds me to remove this after the PR is made
function SMODS.get_interest()
    local add_interest_cap = 0
    local add_per_interest = 0
    for _, area in ipairs(SMODS.get_card_areas('jokers')) do
        for _, _card in ipairs(area.cards) do
            local ret = _card:calculate_interest()
    
            -- TARGET: calc_interest per card
            if ret then
                if ret then
                    if ret.add_cap then
                        add_interest_cap = add_interest_cap + ret.add_cap
                    end
                    if ret.add_per_interest then
                        add_per_interest = add_per_interest + ret.add_per_interest
                    end
                end
            end
        end
    end
    return {interest_cap = add_interest_cap + (G.GAME.extra_interest_cap or 0) + G.GAME.interest_cap/5, per_interest = add_per_interest + (G.GAME.extra_per_interest or 0) + 5}
end

function Card:calculate_interest()
    if not self:can_calculate() then return end
    local obj = self.config.center
    if obj.calc_interest and type(obj.calc_interest) == 'function' then
        return obj:calc_interest(self)
    end
end