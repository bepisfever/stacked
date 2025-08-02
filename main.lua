---@diagnostic disable: unused-function
SMODS.current_mod.optional_features = {retrigger_joker = true}
Stacked = SMODS.current_mod

function Stacked.round(number, digit_position) 
    digit_position = digit_position or 0
    if not number then return end
    local precision = 10 ^ -digit_position
    number = number + (precision / 2)
    return math.floor(number / precision) * precision
end

function Stacked.isxmult(str)
    if str and type(str) == "string" then
        local hasX = string.lower(string.sub(str,1,1)) == "x"
        if hasX then
            local forming_mult = ""
            for i = 1,#str do
                local chr = string.sub(str,i,i)
                forming_mult = forming_mult..string.lower(chr)
            end
            forming_mult = string.gsub(forming_mult,"_","")
            forming_mult = string.gsub(forming_mult," ","")
            if string.find(forming_mult, "mult") then
                return true
            end
        end
    end
    return false
end

function Stacked.ismult(str)
    if str and type(str) == "string" then
        if string.find(string.lower(str), "mult") and not Stacked.isxmult(str) then
            return true
        end
    end
    return false
end

function Stacked.isxchips(str)
    if str and type(str) == "string" then
        local hasX = string.lower(string.sub(str,1,1)) == "x"
        if hasX then
            local forming_mult = ""
            for i = 1,#str do
                local chr = string.sub(str,i,i)
                forming_mult = forming_mult..string.lower(chr)
            end
            forming_mult = string.gsub(forming_mult,"_","")
            forming_mult = string.gsub(forming_mult," ","")
            if string.find(forming_mult, "chip") then
                return true
            end
        end
    end
    return false
end

function Stacked.ischips(str)
    if str and type(str) == "string" then
        if string.find(string.lower(str), "chip") and not Stacked.isxchips(str) then
            return true
        end
    end
    return false
end

ExtraEffects = {
    score_suit_mult = {
        key = "score_suit_mult", 
        ability = {mult = 5, min_possible = 5, max_possible = 20, suit = "Spades"},
        description = {
            text = {
                "{C:inactive}[Attack]{} {C:inactive}({}{V:2}#3#%{}{C:inactive}){}",
                "Scored {V:1}#2#{} cards",
                "give {C:mult}+#1#{} Mult",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.mult, ability_table.suit, Stacked.round(ability_table.perfect, 1), colours = {G.C.SUITS[ability_table.suit], {1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssm_randomize"))
            ability_table.perfect = pseudorandom("ssm_potency_roll", 0, 10) * 10
            ability_table.mult = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.mult = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        calculate = function(card, context, ability_table) 
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit(ability_table.suit) then
                    return{
                        mult = ability_table.mult
                    }
                end
            end
        end,
    },
    score_suit_chips = {
        key = "score_suit_chips", 
        ability = {chips = 5, min_possible = 25, max_possible = 100, suit = "Spades"},
        description = {
            text = {
                "{C:inactive}[Attack]{} {C:inactive}({}{V:2}#3#%{}{C:inactive}){}",
                "Scored {V:1}#2#{} cards",
                "give {C:chips}+#1#{} Chips",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.chips, ability_table.suit, Stacked.round(ability_table.perfect, 1), colours = {G.C.SUITS[ability_table.suit], {1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssc_randomize"))
            ability_table.perfect = pseudorandom("ssc_potency_roll", 0, 10) * 10
            ability_table.chips = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.chips = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        calculate = function(card, context, ability_table) 
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit(ability_table.suit) then
                    return{
                        chips = ability_table.chips
                    }
                end
            end
        end,
    },
    score_suit_xmult = {
        key = "score_suit_xmult", 
        ability = {xmult = 1, min_possible = 1.1, max_possible = 2, suit = "Spades"},
        description = {
            text = {
                "{C:inactive}[Attack]{} {C:inactive}({}{V:2}#3#%{}{C:inactive}){}",
                "Scored {V:1}#2#{} cards",
                "give {X:mult,C:white}X#1#{} Mult",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.xmult, ability_table.suit, Stacked.round(ability_table.perfect, 1), colours = {G.C.SUITS[ability_table.suit], {1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssx_randomize"))
            ability_table.perfect = pseudorandom("ssx_potency_roll", 0, 10) * 10
            ability_table.xmult = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.xmult = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        calculate = function(card, context, ability_table) 
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit(ability_table.suit) then
                    return{
                        xmult = ability_table.xmult
                    }
                end
            end
        end,
    },
    joker_buff1 = {
        key = "joker_buff1", 
        ability = {buff = 1, min_possible = 1, max_possible = 1.5},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker gives {X:dark_edition,C:white}X#1#{} more",
                "{C:chips}Chips{}/{C:mult}Mult{}",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb1_potency_roll", 0, 5) * 20
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        calculate = function(card, context, ability_table) 
            if context.joker_buff then
                return{
                    buff = ability_table.buff
                }
            end
        end,
    },
    joker_buff2 = {
        key = "joker_buff2", 
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker gives {C:blue}+#1#{} Hands",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb2_potency_roll", 0, 1) * 100
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.buff
            local diff = new - old

            ability_table.buff = new
            if diff ~= 0 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + diff
                ease_hands_played(diff)
            end
        end,
        on_apply = function(card, ability_table, repeated)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + ability_table.buff
            ease_hands_played(ability_table.buff)
        end,
        on_remove = function(card, ability_table, card_destroyed)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - ability_table.buff
            ease_hands_played(-ability_table.buff)
        end,
    },
    joker_buff3 = {
        key = "joker_buff3", 
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker gives {C:red}+#1#{} Discards",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb3_potency_roll", 0, 1) * 100
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.buff
            local diff = new - old

            ability_table.buff = new
            if diff ~= 0 then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + diff
                ease_discard(diff)
            end
        end,
        on_apply = function(card, ability_table, repeated)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + ability_table.buff
            ease_discard(ability_table.buff)
        end,
        on_remove = function(card, ability_table, card_destroyed)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - ability_table.buff
            ease_discard(-ability_table.buff)
        end,
    },
    joker_buff4 = {
        key = "joker_buff4", 
        ability = {buff = 1, min_possible = 1, max_possible = 2, remaining = 1},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "Joker is {C:red}immune{} to {C:red}destruction{}",
                "#1# times",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, ability_table.remaining, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb4_potency_roll", 0, 1) * 100
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, repeated, ability_index)
            if ability_table.remaining <= 0 then
                table.remove(card.ability.hsr_extra_effects,ability_index)
            end
        end,
        prevent_destruction = function(card, ability_table, ability_index)
            if ability_table.remaining > 0 then
                ability_table.remaining = ability_table.remaining - 1
                if ability_table.remaining <= 0 then
                    table.remove(card.ability.hsr_extra_effects, ability_index)
                end
                SMODS.calculate_effect({message = "Blocked!"}, card)
                return{
                    block = true
                }
            end
        end,
    },
    joker_buff5 = {
        key = "joker_buff5", 
        ability = {buff = 1, min_possible = 1, max_possible = 1.5},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker's {C:attention}scalings{} are {C:attention}multiplied",
                "by {X:attention,C:white}X#1#",
            },
        },
        in_pool = function(card)
            return false
        end,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb5_potency_roll", 0, 5) * 100
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        modify_scale = function(card, ability_table)
            return{
                scale = ability_table.buff
            }
        end,
    },
    joker_buff6 = {
        key = "joker_buff6", 
        ability = {buff = 1, min_possible = 5, max_possible = 20},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "{C:attention}Blind size{} is decreased",
                "by {C:attention}#1#%{}",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb6_potency_roll", 0, 10) * 10
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.buff
            local diff = new - old

            ability_table.buff = new

            if diff ~= 0 then
                if G.GAME.blind and G.GAME.blind.in_blind then
                    G.GAME.blind.chips = G.GAME.blind.chips * (1 - (diff/100))
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                end
            end
        end,
        on_apply = function(card, ability_table, repeated)
            if G.GAME.blind and G.GAME.blind.in_blind then
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - (ability_table.buff/100))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end,
        calculate = function(card, context, ability_table)
            if context.setting_blind then
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - (ability_table.buff/100))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end,
    },
    joker_buff7 = {
        key = "joker_buff7", 
        ability = {buff = 1, min_possible = 5, max_possible = 10},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "{C:attention}Retrigger{} this Joker {C:attention}once{}",
                "for {C:attention}#1#{} rounds",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb7_potency_roll", 0, 5) * 20
            ability_table.max_buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            ability_table.buff = ability_table.max_buff
        end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.max_buff
            local diff = new - old
            ability_table.max_buff = new
            ability_table.buff = ability_table.buff + diff
        end,
        on_apply = function(card, ability_table, repeated)
            ability_table.buff = ability_table.max_buff
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.retrigger_joker_check and context.other_card == card and ability_table.buff > 0 then
                return{
                    repetitions = 1
                }
            end
            if context.end_of_round and context.main_eval and ability_table.buff > 0 then
                ability_table.buff = ability_table.buff - 1
            end
            if ability_table.buff <= 0 then
                table.remove(card.ability.hsr_extra_effects, ability_index)
            end
        end,
    },
    joker_buff8 = {
        key = "joker_buff8", 
        ability = {buff = 1, min_possible = 1, max_possible = 2, remaining = 1},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "When this Joker would get {C:red}destroyed{},",
                "{C:attention}reset{} its {C:attention}values{} instead",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, ability_table.remaining, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb8_potency_roll", 0, 1) * 100
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, repeated, ability_index)
            if ability_table.remaining <= 0 then
                table.remove(card.ability.hsr_extra_effects,ability_index)
            end
        end,
        prevent_destruction = function(card, ability_table, ability_index)
            if ability_table.remaining > 0 then
                local key = card.config.center.key
                if G.P_CENTERS[key] and G.P_CENTERS[key].config and type(G.P_CENTERS[key].config) == "table" then
                    local function replace_value(t1, t2)
                        for i,v in pairs(t1) do
                            t2[i] = t2[i] or {}
                            if type(v) == "table" then 
                                replace_value(t1[i], t2[i])
                            else
                                t2[i] = t1[i]
                            end
                        end
                    end
                    replace_value(G.P_CENTERS[key].config, card.ability)
                    card:set_cost()
                end
                ability_table.remaining = ability_table.remaining - 1
                if ability_table.remaining <= 0 then
                    table.remove(card.ability.hsr_extra_effects, ability_index)
                end
                SMODS.calculate_effect({message = "Blocked!"}, card)
                return{
                    block = true
                }
            end
        end,
    },
    joker_buff9 = {
        key = "joker_buff9", 
        ability = {buff = "Tarot"},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "When this Joker is {C:attention}destroyed{},",
                "create a {C:attention}#1#{} card",
                "{C:inactive}(Must have room)",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb9_potency_roll", 0, 1) * 100
            ability_table.buff = (ability_table.perfect >= 50) and "Spectral" or "Tarot"
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.perfect >= 50) and "Spectral" or "Tarot"
        end,
        on_destroy = function(card, ability_table)
            if G.consumeables and (#G.consumeables.cards < G.consumeables.config.card_limit) then
                SMODS.add_card({set = ability_table.buff})
            end
        end,
    },
    joker_buff10 = {
        key = "joker_buff10", 
        ability = {mult = 0, buff = 1, min_possible = 50, max_possible = 200},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "{C:mult}+#1#{} Mult",
                "Convert {C:chips}#2#%{} Chips of {C:attention}scored{}",
                "cards to {C:mult}+Mult{}, decreases by {C:attention}half{}",
                "at end of round",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.mult, ability_table.buff * 100, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb10_potency_roll", 0, 100) * 1
            ability_table.buff = ((ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100)))/100
        end,
        update_values = function(card, ability_table)
            ability_table.buff = ((ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100)))/100
        end,
        calculate = function(card, context, ability_table)
            if context.individual and context.cardarea == G.play then
                ability_table.mult = ability_table.mult + (context.other_card:get_chip_bonus() * (1 - ability_table.buff))
            end
            if context.joker_main and ability_table.mult > 0 then
                return{
                    mult = ability_table.mult
                }
            end
            if context.end_of_round and context.main_eval and ability_table.mult > 0 then
                ability_table.mult = math.floor(ability_table.mult/2)
            end
        end,
    },
    joker_buff11 = {
        key = "joker_buff11", 
        ability = {buff = 1, min_possible = 1, max_possible = 5},
        description = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Increase a {C:attention}random{} Effect's {C:attention}Potency{}",
                "of this Joker by {C:attention}#1#%{} {C:inactive}(except itself){}",
                "at end of round",
            },
        },
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = pseudorandom("jb8_potency_roll", 0, 5) * 20
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.end_of_round and context.main_eval and #card.ability.hsr_extra_effects >= 2 then
                local pool = {}
                for i,v in ipairs(card.ability.hsr_extra_effects) do
                    if i ~= ability_index and v.ability and v.ability.perfect then pool[#pool+1] = v end
                end
                local random = pseudorandom_element(pool, pseudoseed("jb11_effect"))
                if random and random.ability and random.ability.perfect and random.ability.perfect < 100 then
                    random.ability.perfect = math.min(random.ability.perfect + ability_table.buff, 100)
                end
            end
        end,
    },
}

local function is_food_joker(joker) --thanks dilly
    if joker.ability.isFood then
        return joker.ability.isFood
    end
    local food_jokers = {
        ['j_gros_michel'] = true,
        ['j_cavendish'] = true,
        ['j_turtle_bean'] = true,
        ['j_ice_cream'] = true,
        ['j_popcorn'] = true,
        ['j_ramen'] = true,
        ['j_seltzer'] = true,
        ['j_diet_cola'] = true,
        ['j_egg'] = true,
    }

    return food_jokers[joker.config.center.key]
end

function table.clone(t) --Clones a table.
    local ret = {}
    for i,v in pairs(t) do
        ret[i] = (type(v) == "table" and table.clone(v)) or v
    end
    return ret
end

--eval apply_extra_effect(G.jokers.cards[1], "score_suit_mult")
function apply_extra_effect(card, effect, bypass_cap)
    card.ability.hsr_extra_effects = card.ability.hsr_extra_effects or {}
    if ExtraEffects[effect] and (bypass_cap or (#card.ability.hsr_extra_effects < (G.GAME.hsr_maximum_extra_effects or 2))) then
        local new_effect = table.clone(ExtraEffects[effect])
        local desc = (G.localization.descriptions.ExtraEffects and G.localization.descriptions.ExtraEffects[effect]) or new_effect.description
        if desc then desc = table.clone(desc); desc.text = {desc.text}; desc = SMODS.stylize_text(desc) end
        card.ability.hsr_extra_effects = card.ability.hsr_extra_effects or {}
        card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects+1] = {key = effect, description = desc}
        card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability = card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability or {}
        for i,v in pairs(new_effect.ability) do
            card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability[i] = v
        end
        if new_effect.randomize_values then
            new_effect.randomize_values(card, card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability, #card.ability.hsr_extra_effects)
        end
        if new_effect.update_values then
            new_effect.update_values(card, card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability, #card.ability.hsr_extra_effects)
        end
        if card.area == G.jokers then
            if new_effect.on_apply and type(new_effect.on_apply) == "function" then
                new_effect.on_apply(card, card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability, card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability.on_apply_flagged, #card.ability.hsr_extra_effects)
                card.ability.hsr_extra_effects[#card.ability.hsr_extra_effects].ability.on_apply_flagged = true
            end
        end
    end
end

local hookTo = Game.start_run
function Game:start_run(...)
    local ret = hookTo(self,...)
    self.GAME.hsr_extra_chance_rate = self.GAME.hsr_extra_chance_rate or 5
    self.GAME.hsr_maximum_extra_effects = self.GAME.hsr_maximum_extra_effects or 2
    return ret
end

local hookTo = Game.update
function Game:update(...)
    for _,card in ipairs((G.jokers and G.jokers.cards) or {}) do
        if card.ability and card.ability.hsr_extra_effects then
            for i,v in ipairs(card.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].modify_scale and type(ExtraEffects[v.key].modify_scale) == "function" then
                    card.hsr_old_ability = card.hsr_old_ability or {}
                    local scale_mod = ExtraEffects[v.key].modify_scale(card, v.ability, i) and ExtraEffects[v.key].modify_scale(card, v.ability, i).scale or 1
                    local function modify(t,n,ref)
                        for ii,vv in pairs(t) do
                            if type(vv) == "table" then
                                ref[ii] = ref[ii] or {}
                                modify(vv,n,ref[ii])
                            elseif type(vv) == "number" and ref[ii] and type(ref[ii]) == "number" and vv ~= ref[ii] then
                                local diff = vv - ref[ii]
                                t[ii] = ref[ii] + (diff * n)
                            end
                        end
                    end
                    modify(card.ability, scale_mod, card.hsr_old_ability)
                end
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].update_values and type(ExtraEffects[v.key].update_values) == "function" then
                    ExtraEffects[v.key].update_values(card, v.ability, i)
                end
            end
            local clone = table.clone(card.ability)
            if clone.hsr_old_ability then clone.hsr_old_ability = nil end
            card.hsr_old_ability = clone
        end
    end
    local ret = hookTo(self,...)
    return ret
end

local hookTo = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    local ret = hookTo(self, card, location, stay_flipped)
    if self == G.jokers then
        if card.ability and card.ability.hsr_extra_effects then
            for i,v in ipairs(card.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_apply and type(ExtraEffects[v.key].on_apply) == "function" then
                    ExtraEffects[v.key].on_apply(card, v.ability, v.ability.on_apply_flagged or false, i)
                    v.ability.on_apply_flagged = true
                end
            end
        end
    end
    return ret
end

local hookTo = Card.remove
function Card:remove()
    if is_food_joker(self) or (self.config.center.pools and self.config.center.pools.Food) then 
        if self.ability and self.ability.hsr_extra_effects then
            for i,v in ipairs(self.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_destroy and type(ExtraEffects[v.key].on_destroy) == "function" and not v.ability.on_destroy_flagged then
                    self.ability.hsr_extra_effects[i].ability.on_destroy_flagged = true
                    local on_destroy = ExtraEffects[v.key].on_destroy(self, v.ability, i)
                end
            end

            for i,v in ipairs(self.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].prevent_destruction and type(ExtraEffects[v.key].prevent_destruction) == "function" then
                    local pd = ExtraEffects[v.key].prevent_destruction(self, v.ability, i)
                    if pd and pd.block then
                        local new_card = copy_card(self)
                        for i,v in ipairs(new_card.ability.hsr_extra_effects) do
                            if v.ability then
                                new_card.ability.hsr_extra_effects[i].ability.on_destroy_flagged = false
                                new_card.ability.hsr_extra_effects[i].ability.on_apply_flagged = false
                                new_card.ability.hsr_extra_effects[i].ability.on_remove_flagged = false
                            end
                        end
                        if new_card.add_to_deck then new_card:add_to_deck() end
                        G.jokers:emplace(new_card)
                    end
                end
            end

            for i,v in ipairs(self.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_remove and type(ExtraEffects[v.key].on_remove) == "function" and not v.ability.on_remove_flagged then
                    v.ability.on_remove_flagged = true
                    local on_remove = ExtraEffects[v.key].on_remove(self, v.ability, true, i)
                end
            end
        end
        local ret = hookTo(self)
        return ret
    else
        if self.ability and self.ability.hsr_extra_effects and self.area == G.jokers then
            for i,v in ipairs(self.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_destroy and type(ExtraEffects[v.key].on_destroy) == "function" and not v.ability.on_destroy_flagged then
                    self.ability.hsr_extra_effects[i].ability.on_destroy_flagged = true
                    local on_destroy = ExtraEffects[v.key].on_destroy(self, v.ability, i)
                end
            end

            for i,v in ipairs(self.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].prevent_destruction and type(ExtraEffects[v.key].prevent_destruction) == "function" then
                    local pd = ExtraEffects[v.key].prevent_destruction(self, v.ability, i)
                    if pd and pd.block then
                        for i,v in ipairs(self.ability.hsr_extra_effects) do
                            if v.ability and v.ability.on_destroy_flagged then
                                self.ability.hsr_extra_effects[i].ability.on_destroy_flagged = false
                            end
                        end
                        return
                    end
                end
            end

            for i,v in ipairs(self.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_remove and type(ExtraEffects[v.key].on_remove) == "function" and not v.ability.on_remove_flagged then
                    v.ability.on_remove_flagged = true
                    local on_remove = ExtraEffects[v.key].on_remove(self, v.ability, true, i)
                end
            end
        end
    end
    local ret = hookTo(self)
    return ret
end

local hookTo = Card.start_dissolve
function Card:start_dissolve(...)
    if self.ability and self.ability.hsr_extra_effects and self.area == G.jokers then
        for i,v in ipairs(self.ability.hsr_extra_effects) do
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_destroy and type(ExtraEffects[v.key].on_destroy) == "function" and not v.ability.on_destroy_flagged then
                self.ability.hsr_extra_effects[i].ability.on_destroy_flagged = true
                local on_destroy = ExtraEffects[v.key].on_destroy(self, v.ability, i)
            end
        end

        for i,v in ipairs(self.ability.hsr_extra_effects) do
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].prevent_destruction and type(ExtraEffects[v.key].prevent_destruction) == "function" then
                local pd = ExtraEffects[v.key].prevent_destruction(self, v.ability, i)
                if pd and pd.block then
                    for i,v in ipairs(self.ability.hsr_extra_effects) do
                        if v.ability and v.ability.on_destroy_flagged then
                            self.ability.hsr_extra_effects[i].ability.on_destroy_flagged = false
                        end
                    end
                    return
                end
            end
        end

        for i,v in ipairs(self.ability.hsr_extra_effects) do
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_remove and type(ExtraEffects[v.key].on_remove) == "function" and not v.ability.on_remove_flagged then
                v.ability.on_remove_flagged = true
                local on_remove = ExtraEffects[v.key].on_remove(self, v.ability, true, i)
            end
        end
    end
    local ret = hookTo(self,...)
    return ret
end

local hookTo = Card.calculate_joker
function Card:calculate_joker(context)
    local o, t = hookTo(self, context)
    local ret = o
    if self.ability and self.ability.hsr_extra_effects then
        for i,v in ipairs(self.ability.hsr_extra_effects) do
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].calculate and type(ExtraEffects[v.key].calculate) == "function" then
                local calc = ExtraEffects[v.key].calculate(self, context, v.ability, i)
                if calc then
                    ret = SMODS.merge_effects({ret or {}, calc or {}})
                end
                local function recursive_check(t)
                    local shits_and_giggles = {"xmult", "mult", "xchips", "chips"}
                    for i,vv in pairs(t) do
                        if type(vv) == "number" then
                            for _,vvv in ipairs(shits_and_giggles) do
                                if Stacked["is"..vvv] and type(Stacked["is"..vvv]) == "function" and Stacked["is"..vvv](i) then
                                    local calc1 = ExtraEffects[v.key].calculate(self, {[vvv.."_buff"] = true}, v.ability)
                                    local calc2 = ExtraEffects[v.key].calculate(self, {joker_buff = true}, v.ability)
                                    local new = t[i] * (calc1 and calc1.buff or 1) * (calc2 and calc2.buff or 1)
                                    if t.message then
                                        t.message = string.gsub(t.message, t[i], new)
                                    end
                                    t[i] = new
                                end
                            end
                        elseif type(vv) == "table" and i == "extra" then
                            recursive_check(t)
                        end
                    end
                end
                if ret then
                    recursive_check(ret)
                end
            end
        end
    end
    if ret or t then return ret, t end
end

local hookTo = Card.set_ability
function Card:set_ability(...)
    local exist_element = self.ability and self.ability.hsr_extra_effects or {}
    local ret = hookTo(self,...)

    local dont = false
    for _,v in ipairs(G.I.CARDAREA) do
        if v.config.collection then dont = true; break end
    end
    if self.config.center.set == "Joker" and not dont and G.STAGE == G.STAGES.RUN then
        if #exist_element < (G.GAME.hsr_maximum_extra_effects or 2) then
            for _ = 1, (G.GAME.hsr_maximum_extra_effects or 2) - #exist_element do
                local odd = pseudorandom("hsr_feeling_lucky_today") <= 1/(G.GAME.hsr_extra_chance_rate or 5)
                if odd then
                    local pool = {}
                    for i,v in pairs(ExtraEffects) do
                        if v.in_pool and type(v.in_pool) == "function" then
                            if v.in_pool(self) then
                                pool[#pool+1] = i
                            end
                        else
                            pool[#pool+1] = i
                        end
                    end
                    if #pool > 0 then
                        local random_effect = pseudorandom_element(pool, pseudoseed("hsr_im_feeling_super_lucky_today_:3"))
                        if random_effect then
                            apply_extra_effect(self, random_effect)
                        end
                    end
                end
            end
        end
    end

    return ret
end

local hookTo = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table(...)
    local ret = hookTo(self,...)
    if self.ability and self.ability.hsr_extra_effects then
        ret.multi_box = ret.multi_box or {}
        local existing_mb = #ret.multi_box
        local increase = 0
        ret.box_colours = ret.box_colours or {}
        ret.main = ret.main or {}
        ret.main.main_box_flag = true
        for _,v in ipairs(self.ability.hsr_extra_effects) do
            local desc = v.description
            increase = increase + 1
            for i, box in ipairs(desc.text_parsed) do
                for j, line in ipairs(box) do
                    local final_line = SMODS.localize_box(line, (v.key and ExtraEffects[v.key] and ExtraEffects[v.key].loc_vars and ExtraEffects[v.key].loc_vars({}, self, v.ability)) or {})
                    ret.multi_box[existing_mb + increase] = ret.multi_box[existing_mb + increase] or {}
                    ret.multi_box[existing_mb + increase][#ret.multi_box[existing_mb + increase]+1] = final_line
                    if not next(ret.info) then ret.box_colours[i] = G.C.UI.BACKGROUND_WHITE end
                end
            end
        end
    end
    return ret
end

SMODS.stylize_text = function(text, args)
    if not text then return end
    if type(text) ~= "table" then text = {text} end
    local args = args or {}
    local loc_dir1 = args.loc_dir1 or "misc"
    local loc_dir2 = args.loc_dir2 or "v_text_parsed"
    local key = args.key or "SMODS_stylize_text"
    local function deep_find(t, index)
        if type(index) ~= "table" then index = {index} end
        for _,idv_index in ipairs(index) do
            if t[idv_index] then return true end
            for i,v in pairs(t) do
                if i == idv_index then return true end
                if type(v) == "table" then
                    return deep_find(v, idv_index)
                end
            end
        end
        return false
    end
    if deep_find(text, "control") then 
        if not args.no_loc_save then G.localization[loc_dir1][loc_dir2] = text end 
        return text 
    end

    local a = {"text", "name", "unlock"}
    if not args.no_loc_save then
        local loc = G.localization[loc_dir1][loc_dir2]
        loc[key] = {}
        if deep_find(text, a) then
            for _,v in ipairs(a) do
                text[v] = text[v] or {}
                text[v.."_parsed"] = text[v.."_parsed"] or {}
            end
            if text.text then
                for _,v in ipairs(text.text) do
                    if type(v) == "table" then
                        text.text_parsed[#text.text_parsed+1] = {}
                        for _, vv in ipairs(v) do
                            text.text_parsed[#text.text_parsed][#text.text_parsed[#text.text_parsed]+1] = loc_parse_string(vv)
                        end
                    else
                        text.text_parsed[#text.text_parsed+1] = loc_parse_string(v)
                    end
                end
            end
            if text.name then
                for _,v in ipairs((type(text.name) == "string" and {text.name}) or text.name) do
                    text.name_parsed[#text.name_parsed+1] = loc_parse_string(v)
                end
            end
            if text.unlock then
                for _,v in ipairs(text.unlock) do
                    text.unlock_parsed[#text.unlock_parsed+1] = loc_parse_string(v)
                end
            end
            loc[key] = text
        else
            for i,v in ipairs(text) do
                loc[key][i] = loc_parse_string(v)
            end
        end
        return loc[key]
    else
        local loc = {}
        if deep_find(text, a) then
            for _,v in ipairs(a) do
                text[v] = text[v] or {}
                text[v.."_parsed"] = text[v.."_parsed"] or {}
            end
            if text.text then
                for _,v in ipairs(text.text) do
                    if type(v) == "table" then
                        text.text_parsed[#text.text_parsed+1] = {}
                        for _, vv in ipairs(v) do
                            text.text_parsed[#text.text_parsed][#text.text_parsed[#text.text_parsed]+1] = loc_parse_string(vv)
                        end
                    else
                        text.text_parsed[#text.text_parsed+1] = loc_parse_string(v)
                    end
                end
            end
            if text.name then
                for _,v in ipairs((type(text.name) == "string" and {text.name}) or text.name) do
                    text.name_parsed[#text.name_parsed+1] = loc_parse_string(v)
                end
            end
            if text.unlock then
                for _,v in ipairs(text.unlock) do
                    text.unlock_parsed[#text.unlock_parsed+1] = loc_parse_string(v)
                end
            end
            loc = text
        else
            for i,v in ipairs(text) do
                loc[i] = loc_parse_string(v)
            end
        end
        
        return loc
    end
end

function SMODS.localize(args, misc_cat)
    if args and not (type(args) == 'table') then
        if misc_cat and G.localization.misc[misc_cat] then return G.localization.misc[misc_cat][args] or 'ERROR' end
        return G.localization.misc.dictionary[args] or 'ERROR'
    end
    args = args or {}
    args.nodes = args.nodes or {}

    local loc_target = args.loc_target or nil
    if args.stylize then loc_target = SMODS.stylize_text(loc_target) end
    local ret_string = nil
    if args.type == 'other' then
        if not loc_target then loc_target = G.localization.descriptions.Other[args.key] end
    elseif args.type == 'descriptions' or args.type == 'unlocks' then 
        if not loc_target then loc_target = G.localization.descriptions[args.set][args.key] end
    elseif args.type == 'tutorial' then 
        if not loc_target then loc_target = G.localization.tutorial_parsed[args.key] end
    elseif args.type == 'quips' then 
        if not loc_target then loc_target = G.localization.quips_parsed[args.key] end
    elseif args.type == 'raw_descriptions' then 
        if not loc_target then loc_target = G.localization.descriptions[args.set][args.key] end
        local multi_line = {}
        if loc_target then 
            for _, lines in ipairs(args.type == 'unlocks' and loc_target.unlock_parsed or args.type == 'name' and loc_target.name_parsed or args.type == 'text' and loc_target or loc_target.text_parsed) do
                local final_line = ''
                for _, part in ipairs(lines) do
                    local assembled_string = ''
                    for _, subpart in ipairs(part.strings) do
                        assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]) or 'ERROR')
                    end
                    final_line = final_line..assembled_string
                end
                multi_line[#multi_line+1] = final_line
            end
        end
        return multi_line
    elseif args.type == 'text' then
        if not loc_target then loc_target = G.localization.misc.v_text_parsed[args.key] end
    elseif args.type == 'variable' then 
        if not loc_target then loc_target = G.localization.misc.v_dictionary_parsed[args.key] end
        if not loc_target then return 'ERROR' end 
        if loc_target.multi_line then
            local assembled_strings = {}
            for k, v in ipairs(loc_target) do
                local assembled_string = ''
                for _, subpart in ipairs(v[1].strings) do
                    assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]))
                end
                assembled_strings[k] = assembled_string
            end
            return assembled_strings or {'ERROR'}
        else
            local assembled_string = ''
            for _, subpart in ipairs(loc_target[1].strings) do
                assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]))
            end
            ret_string = assembled_string or 'ERROR'
        end
    elseif args.type == 'name_text' then
        if pcall(function()
            local name_text = (loc_target and loc_target.name) or G.localization.descriptions[(args.set or args.node.config.center.set)][args.key or args.node.config.center.key].name
            if type(name_text) == "table" then
                ret_string = ""
                for i, line in ipairs(name_text) do
                    ret_string = ret_string.. (i ~= 1 and " " or "")..line
                end
            else
                ret_string = name_text
            end
        end) then
        else ret_string = "ERROR" end
    elseif args.type == 'name' then
        loc_target = loc_target or {}
        if pcall(function()
            local name = loc_target or G.localization.descriptions[(args.set or args.node.config.center.set)][args.key or args.node.config.center.key]
            loc_target.name_parsed = name.name_parsed or {loc_parse_string(name.name)}
        end) then
        else loc_target.name_parsed = {} end
    end

    if ret_string and type(ret_string) == 'string' then ret_string = string.gsub(ret_string, "{.-}", "") end
    if ret_string then return ret_string end

    if loc_target then 
        args.AUT = args.AUT or {}
        args.AUT.box_colours = {}
        if (args.type == 'descriptions' or args.type == 'other') and type(loc_target.text) == 'table' and type(loc_target.text[1]) == 'table' then
            args.AUT.multi_box = {}
            for i, box in ipairs(loc_target.text_parsed) do
                for j, line in ipairs(box) do
                    local final_line = SMODS.localize_box(line, args)
                    if i == 1 or next(args.AUT.info) then
                        args.nodes[#args.nodes+1] = final_line -- Sends main box to AUT.main
                        if not next(args.AUT.info) then args.nodes.main_box_flag = true end
                    elseif not next(args.AUT.info) then 
                        args.AUT.multi_box[i-1] = args.AUT.multi_box[i-1] or {}
                        args.AUT.multi_box[i-1][#args.AUT.multi_box[i-1]+1] = final_line
                    end
                    if not next(args.AUT.info) then args.AUT.box_colours[i] = args.vars.box_colours and args.vars.box_colours[i] or G.C.UI.BACKGROUND_WHITE end
                end
            end
            return
        end
        for _, lines in ipairs(args.type == 'unlocks' and loc_target.unlock_parsed or args.type == 'name' and loc_target.name_parsed or (args.type == 'text' or args.type == 'tutorial' or args.type == 'quips') and loc_target or loc_target.text_parsed) do
            local final_line = {}
            local final_name_assembled_string = ''
            if args.type == 'name' and loc_target.name_parsed then
                for _, part in ipairs(lines) do
                    local assembled_string_part = ''
                    for _, subpart in ipairs(part.strings) do
                        assembled_string_part = assembled_string_part..(type(subpart) == 'string' and subpart or format_ui_value(format_ui_value(args.vars[tonumber(subpart[1])])) or 'ERROR')
                    end
                    final_name_assembled_string = final_name_assembled_string..assembled_string_part
                end
            end
            for _, part in ipairs(lines) do
                local assembled_string = ''
                for _, subpart in ipairs(part.strings) do
                    assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]) or 'ERROR')
                end
                local desc_scale = (SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or G.LANG.font).DESCSCALE
                if G.F_MOBILE_UI then desc_scale = desc_scale*1.5 end
                if args.type == 'name' then
                    final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or part.control.X and loc_colour(part.control.X) or nil, r = 0.05, padding = 0.03, res = 0.15}, nodes={}}
                    final_line[#final_line].nodes[1] = {n=G.UIT.O, config={
                        object = DynaText({string = {assembled_string},
                            colours = {(part.control.V and args.vars.colours[tonumber(part.control.V)]) or (part.control.C and loc_colour(part.control.C)) or args.text_colour or G.C.UI.TEXT_LIGHT},
                            bump = not args.no_bump,
                            silent = not args.no_silent,
                            pop_in = (not args.no_pop_in and (args.pop_in or 0)) or nil,
                            pop_in_rate = (not args.no_pop_in and (args.pop_in_rate or 4)) or nil,
                            maxw = args.maxw or 5,
                            shadow = not args.no_shadow,
                            y_offset = args.y_offset or -0.6,
                            spacing = (not args.no_spacing and (args.spacing or 1) * math.max(0, 0.32*(17 - #(final_name_assembled_string or assembled_string)))) or nil,
                            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                            scale = (0.55 - 0.004*#(final_name_assembled_string or assembled_string))*(part.control.s and tonumber(part.control.s) or args.scale or 1)*(args.fixed_scale or 1)
                        })
                    }}
                elseif part.control.E then
                    local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
                    if part.control.E == '1' then
                        _float = true; _silent = true; _pop_in = 0
                    elseif part.control.E == '2' then
                        _bump = true; _spacing = 1
                    end
                    final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or part.control.X and loc_colour(part.control.X) or nil, r = 0.05, padding = 0.03, res = 0.15}, nodes={}}
                    final_line[#final_line].nodes[1] = {n=G.UIT.O, config={
                        object = DynaText({string = {assembled_string}, colours = {part.control.V and args.vars.colours[tonumber(part.control.V)] or loc_colour(part.control.C or nil)},
                            float = _float,
                            silent = _silent,
                            pop_in = _pop_in,
                            bump = _bump,
                            spacing = (args.spacing or 1) * _spacing,
                            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                            scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale or 1)*desc_scale*(args.fixed_scale or 1)
                        })
                    }}
                elseif part.control.X or part.control.B then
                    final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or loc_colour(part.control.X), r = 0.05, padding = 0.03, res = 0.15}, nodes={
                        {n=G.UIT.T, config={
                            text = assembled_string,
                            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                            colour = part.control.V and args.vars.colours[tonumber(part.control.V)] or loc_colour(part.control.C or nil),
                            scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale or 1)*desc_scale*(args.fixed_scale or 1)
                        }},
                    }}
                else
                    final_line[#final_line+1] = {n=G.UIT.T, config={
                        detailed_tooltip = part.control.T and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T]) or nil,
                        text = assembled_string,
                        font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                        shadow = not args.no_shadow or args.shadow,
                        colour = part.control.V and args.vars.colours[tonumber(part.control.V)] or not part.control.C and args.text_colour or loc_colour(part.control.C or nil, args.default_col),
                        scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale or 1)*desc_scale*(args.fixed_scale or 1)
                    }}
                end
            end
            if args.type == 'text' then return final_line end
            if not args.nodes and args.type == 'name' then args.nodes = {} end
            args.nodes[#args.nodes+1] = final_line
        end
        if args.type == 'name' then
            local final_name = {}
        
            for _, line in ipairs(args.nodes or {}) do
                final_name[#final_name+1] = {n=G.UIT.R, config={align = "m"}, nodes=line}
            end
        
            return final_name
        end
    end

    return args.nodes
end
