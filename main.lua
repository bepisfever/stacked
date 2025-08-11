SMODS.current_mod.optional_features = {retrigger_joker = true}
Stacked = SMODS.current_mod
Stacked.effect_per_page = 2
Stacked.stakes_without_curses = {1,2,3}

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

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end

    G.ARGS.LOC_COLOURS["stck_cursed"] = SMODS.Gradients["stck_cursed"]
    G.ARGS.LOC_COLOURS["stck_m_a_c"] = SMODS.Gradients["stck_m_a_c"]

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