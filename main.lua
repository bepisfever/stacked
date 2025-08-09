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