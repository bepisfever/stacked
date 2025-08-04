ExtraEffects = {
    score_suit_mult = {
        key = "score_suit_mult", 
        ability = {mult = 5, min_possible = 5, max_possible = 20, suit = "Spades"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.mult, ability_table.suit, Stacked.round(ability_table.perfect, 1), colours = {G.C.SUITS[ability_table.suit], {1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssm_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "ssm_potency_roll", min = 0, max = 10}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.chips, ability_table.suit, Stacked.round(ability_table.perfect, 1), colours = {G.C.SUITS[ability_table.suit], {1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssc_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "ssc_potency_roll", min = 0, max = 10}
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
        ability = {xmult = 1, min_possible = 1.1, max_possible = 1.5, suit = "Spades"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.xmult, ability_table.suit, Stacked.round(ability_table.perfect, 1), colours = {G.C.SUITS[ability_table.suit], {1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssx_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "ssx_potency_roll", min = 0, max = 10}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb1_potency_roll", min = 0, max = 5}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb2_potency_roll", min = 0, max = 1}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb3_potency_roll", min = 0, max = 1}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, ability_table.remaining, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb4_potency_roll", min = 0, max = 1}
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
        in_pool = function(card)
            return false
        end,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb5_potency_roll", min = 0, max = 5}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb6_potency_roll", min = 0, max = 10}
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
        on_remove = function(card, ability_table, card_destroyed)
            if G.GAME.blind and G.GAME.blind.in_blind then
                G.GAME.blind.chips = G.GAME.blind.chips / (1 - (ability_table.buff/100))
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb7_potency_roll", min = 0, max = 5}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, ability_table.remaining, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb8_potency_roll", min = 0, max = 1}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb9_potency_roll", min = 0, max = 1}
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
        ability = {mult = 0, buff = 1, min_possible = 10, max_possible = 50},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.mult, ability_table.buff * 100, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb10_potency_roll", min = 0, max = 100}
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
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        in_pool = function(card)
            if not card.ability or not card.ability.hsr_extra_effects or #card.ability.hsr_extra_effects <= 0 then
                return false
            else
                return true
            end
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb11_potency_roll", min = 0, max = 5}
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
                    random.ability.perfect = math.min(random.ability.perfect + ability_table.buff, G.GAME.hsr_potency_cap or 100)
                end
            end
        end,
    },
    joker_buff12 = {
        key = "joker_buff12", 
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb12_potency_roll", min = 0, max = 1}
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        on_destroy = function(card, ability_table)
            for _ = 1, ability_table.buff do
                local valid_pool = {}
                for _,v in ipairs(G.jokers and G.jokers.cards or {}) do
                    if v ~= card and (not v.ability.hsr_extra_effects or (#v.ability.hsr_extra_effects < G.GAME.hsr_maximum_extra_effects)) then valid_pool[#valid_pool+1] = v end
                end
                if #valid_pool > 0 then
                    local random_joker = pseudorandom_element(valid_pool, pseudoseed("jb12_choose"))
                    if random_joker then
                        SMODS.calculate_effect({message = "New Effect!"}, random_joker)
                        apply_extra_effect(random_joker)
                    end
                end
            end
        end,
    },
    joker_buff13 = {
        key = "joker_buff13", 
        ability = {buff = 1, min_possible = 0, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb13_potency_roll", min = 0, max = 4}
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        probability_vars = function(card, ability_table, probvars, ability_index)
            probvars = probvars or {}
            probvars[1] = probvars[1] or 0
            probvars[1] = probvars[1] + ability_table.buff

            return probvars
        end,
    },
    joker_buff14 = {
        key = "joker_buff14", 
        ability = {direction = "left", buff = 1, min_possible = 0.2, max_possible = 0.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction), ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jb14_dir_roll"))
            ability_table.perfect = Stacked.poll_potency{seed = "jb14_potency_roll", min = 0, max = 4}
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        calculate = function(card, context, ability_table)
            local ret = {}
            if context.joker_buff then
                ret.buff = ability_table.buff
            end
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[(ability_table.direction == "right" and i+1) or i-1] end
            end
            if other_joker then
                return SMODS.merge_effects({(SMODS.blueprint_effect(card, other_joker, context) or {}), ret})
            end
        end
    },
    joker_buff15 = {
        key = "joker_buff15", 
        ability = {buff = 1, min_possible = 1, max_possible = 5, x = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.x, ability_table.buff, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb15_potency_roll", min = 0, max = 25}
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        detect_value_change = function(card, ability_table, change, ability_index)
            if change >= 0.2 and change <= ability_table.buff and (ability_table.cap_x or 0) < 0.1 then
                ability_table.x = ability_table.x + 0.02
                ability_table.cap_x = (ability_table.cap_x or 0) + 0.02
                SMODS.calculate_effect({message = "Upgraded!", colour = G.C.DARK_EDITION}, card)
            end
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.end_of_round and context.main_eval then
                ability_table.cap_x = 0
            end
            if context.joker_buff then
                return{
                    buff = ability_table.x
                }
            end
        end,
    },
    joker_buff16 = {
        key = "joker_buff16", 
        ability = {buff = 1, min_possible = 1, max_possible = 15, remaining = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, ability_table.remaining, Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb16_potency_roll", min = 0, max = 14}
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
        prevent_other_destruction = function(card, ability_table, other_card, ability_index)
            if ability_table.remaining > 0 and other_card.playing_card then
                ability_table.remaining = ability_table.remaining - 1
                if ability_table.remaining <= 0 then
                    table.remove(card.ability.hsr_extra_effects, ability_index)
                end
                SMODS.calculate_effect({message = "Blocked!"}, other_card)
                return{
                    block = true
                }
            end
        end,
    },
    joker_buff17 = {
        key = "joker_buff17", 
        ability = {direction = "left", buff = 1, min_possible = 0.01, max_possible = 0.05},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction), Stacked.round(ability_table.buff,3), Stacked.round(ability_table.perfect, 1), colours = {{1 - (1 * ability_table.perfect/100), 1 * ability_table.perfect/100, 0, 1}}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jb17_dir_roll"))
            ability_table.perfect = Stacked.poll_potency{seed = "jb17_potency_roll", min = 0, max = 10}
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (ability_table.min_possible) + ((ability_table.max_possible - ability_table.min_possible) * (ability_table.perfect/100))
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function mult_to_xmult(t)
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        mult_to_xmult(v)
                    elseif i == "mult" then
                        t["xmult"] = 1 + (math.floor(v) * ability_table.buff)
                        t[i] = nil
                    elseif i == "mult_mod" then
                        t["xmult"] = 1 + (math.floor(v) * ability_table.buff)
                        if t["message"] and type(t["message"]) == "string" and string.find(t["message"], "+"..v) then
                            t["message"] = nil
                        end
                        t[i] = nil
                    end
                end
            end

            for i,v in ipairs(G.jokers and G.jokers.cards or {}) do
                if v == card then
                    if ability_table.direction == "left" and G.jokers.cards[i-1] == other_card then
                        mult_to_xmult(ret)
                        break
                    elseif ability_table.direction == "right" and G.jokers.cards[i+1] == other_card then
                        mult_to_xmult(ret)
                        break
                    end
                end
            end
        end,
    },
    joker_buff18 = {
        key = "joker_buff18", 
        no_potency = true,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb18_potency_roll", min = 1, max = 1}
        end,
        check_showman = function(card, ability_table, card_key, abiltiy_index)
            if card_key == card.config.center.key then
                return true
            end
        end,
    },
}