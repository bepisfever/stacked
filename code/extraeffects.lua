ExtraEffects = {
    score_suit_mult = {
        key = "score_suit_mult", 
        type = "attack",
        ability = {mult = 5, min_possible = 5, max_possible = 20, suit = "Spades"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.mult, ability_table.suit, colours = {G.C.SUITS[ability_table.suit]}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssm_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "ssm_potency_roll", min = 0, max = 10}
            ability_table.mult = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.mult = Stacked.calc_min_max(ability_table)
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
        type = "attack",
        ability = {chips = 5, min_possible = 25, max_possible = 100, suit = "Spades"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.chips, ability_table.suit, colours = {G.C.SUITS[ability_table.suit]}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssc_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "ssc_potency_roll", min = 0, max = 10}
            ability_table.chips = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.chips = Stacked.calc_min_max(ability_table)
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
        type = "attack",
        ability = {xmult = 1, min_possible = 1.1, max_possible = 1.5, suit = "Spades"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.xmult, ability_table.suit, colours = {G.C.SUITS[ability_table.suit]}}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.suit = pseudorandom_element({"Spades", "Hearts", "Clubs", "Diamonds"}, pseudoseed(card.config.center.key.."ssx_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "ssx_potency_roll", min = 0, max = 10}
            ability_table.xmult = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.xmult = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 1.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb1_potency_roll", min = 0, max = 5}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, string.lower(ability_table.buff <= 1 and localize("stck_singular_hands") or localize("stck_plural_hands"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb2_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old

            ability_table.buff = new
            if diff ~= 0 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + diff
                ease_hands_played(diff)
            end
        end,
        on_apply = function(card, ability_table, ability_index)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + ability_table.buff
            ease_hands_played(ability_table.buff)
        end,
        on_remove = function(card, ability_table, card_destroyed, ability_index)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - ability_table.buff
            ease_hands_played(-ability_table.buff)
        end,
    },
    joker_buff3 = {
        key = "joker_buff3", 
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, string.lower(ability_table.buff <= 1 and localize("stck_singular_discards") or localize("stck_plural_discards"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb3_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old

            ability_table.buff = new
            if diff ~= 0 then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + diff
                ease_discard(diff)
            end
        end,
        on_apply = function(card, ability_table, ability_index)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + ability_table.buff
            ease_discard(ability_table.buff)
        end,
        on_remove = function(card, ability_table, card_destroyed, ability_index)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - ability_table.buff
            ease_discard(-ability_table.buff)
        end,
    },
    joker_buff4 = {
        key = "joker_buff4", 
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 2, remaining = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, math.ceil(ability_table.remaining), string.lower(ability_table.buff <= 1 and localize("stck_singular_times") or localize("stck_plural_times"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb4_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, ability_index)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 1.5},
        in_pool = function(card)
            return false
        end,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb5_potency_roll", min = 0, max = 5}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        modify_scale = function(card, ability_table)
            return{
                scale = ability_table.buff
            }
        end,
    },
    joker_buff6 = {
        key = "joker_buff6", 
        type = "passive",
        ability = {buff = 1, min_possible = 5, max_possible = 20},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb6_potency_roll", min = 0, max = 10}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
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
        on_apply = function(card, ability_table, ability_index)
            if G.GAME.blind and G.GAME.blind.in_blind then
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - (ability_table.buff/100))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end,
        on_remove = function(card, ability_table, card_destroyed, ability_index)
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
        type = "passive",
        ability = {buff = 1, min_possible = 5, max_possible = 10},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, string.lower(ability_table.buff <= 1 and localize("stck_singular_rounds") or localize("stck_plural_rounds"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb7_potency_roll", min = 0, max = 5}
            ability_table.max_buff = Stacked.calc_min_max(ability_table)
            ability_table.buff = ability_table.max_buff
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.max_buff
            local diff = new - old
            ability_table.max_buff = new
            ability_table.buff = ability_table.buff + diff
        end,
        on_apply = function(card, ability_table, ability_index)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 2, remaining = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, math.ceil(ability_table.remaining)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb8_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, ability_index)
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
        type = "passive",
        ability = {buff = "Tarot"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
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
        type = "passive",
        ability = {mult = 0, buff = 1, min_possible = 10, max_possible = 50},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.mult, ability_table.buff * 100}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb10_potency_roll", min = 0, max = 100}
            ability_table.buff = (Stacked.calc_min_max(ability_table))/100
        end,
        update_values = function(card, ability_table)
            ability_table.buff = (Stacked.calc_min_max(ability_table))/100
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
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
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, string.lower(ability_table.buff <= 1 and localize("stck_singular_times") or localize("stck_plural_times"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb12_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb13_potency_roll", min = 0, max = 4}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {direction = "left", buff = 1, min_possible = 0.2, max_possible = 0.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction), ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jb14_dir_roll"))
            ability_table.perfect = Stacked.poll_potency{seed = "jb14_potency_roll", min = 0, max = 4}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 5, x = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.x, ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb15_potency_roll", min = 0, max = 25}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
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
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 15, remaining = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {math.ceil(ability_table.buff), math.ceil(ability_table.remaining), string.lower(math.ceil(ability_table.remaining) <= 1 and localize("stck_singular_times") or localize("stck_plural_times"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb16_potency_roll", min = 0, max = 14}
            ability_table.buff = Stacked.calc_min_max(ability_table)
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, ability_index)
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
        type = "passive",
        ability = {direction = "left", buff = 1, min_possible = 0.01, max_possible = 0.05},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction), Stacked.round(ability_table.buff,3)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jb17_dir_roll"))
            ability_table.perfect = Stacked.poll_potency{seed = "jb17_potency_roll", min = 0, max = 10}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function mult_to_xmult(t)
                local xmult_gain = 0
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        mult_to_xmult(v)
                    elseif i == "mult" or i == "h_mult" and v ~= 0 then
                        xmult_gain = (math.floor(v) * ability_table.buff)
                        t[i] = nil
                    elseif i == "mult_mod" and v ~= 0 then
                        xmult_gain = (math.floor(v) * ability_table.buff)
                        if t["message"] and type(t["message"]) == "string" and string.find(t["message"], "+"..v) then
                            t["message"] = nil
                        end
                        t[i] = nil
                    end
                end

                if xmult_gain ~= 0 then
                    t["xmult"] = (t["xmult"] or 1) + xmult_gain
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
        type = "passive",
        no_potency = true,
        check_showman = function(card, ability_table, card_key, abiltiy_index)
            if card_key == card.config.center.key then
                return true
            end
        end,
    },
    joker_buff19 = {
        key = "joker_buff19", 
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 3},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, string.lower(ability_table.buff <= 1 and localize("stck_singular_times") or localize("stck_plural_times"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb19_potency_roll", min = 0, max = 3}
            ability_table.buff = math.ceil(Stacked.calc_min_max(ability_table))
        end,
        update_values = function(card, ability_table)
            ability_table.buff = math.ceil(Stacked.calc_min_max(ability_table))
        end,
        probability_reroll = function(card, obj, res, ability_table, ability_index, numerator, denominator)
            if card == obj and not res then
                return{
                    to_true = ability_table.buff,
                    func = function()
                        SMODS.calculate_effect({message = "Rerolled!", colour = G.C.GREEN}, card)
                    end,
                }
            end
        end,
    },
    joker_buff20 = {
        key = "joker_buff20", 
        type = "passive",
        ability = {buff = 1, min_possible = 5, max_possible = 15},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.buff,1)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb20_potency_roll", min = 0, max = 10}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
                return{
                    mult = Stacked.round(ability_table.buff,1)
                }
            end
        end,
    },
    joker_buff21 = {
        key = "joker_buff21", 
        type = "passive",
        ability = {buff = 1, min_possible = 15, max_possible = 50},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.buff,1)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb21_potency_roll", min = 0, max = 10}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
                return{
                    chips = Stacked.round(ability_table.buff,1)
                }
            end
        end,
    },
    joker_buff22 = {
        key = "joker_buff22", 
        type = "passive",
        ability = {buff = 1, min_possible = 1.1, max_possible = 1.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.buff,1)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb22_potency_roll", min = 0, max = 5}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main then
                return{
                    xmult = Stacked.round(ability_table.buff,1)
                }
            end
        end,
    },
    joker_buff23 = {
        key = "joker_buff23", 
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb23_potency_roll", min = 0, max = 5}
            ability_table.buff = math.floor(Stacked.calc_min_max(ability_table))
        end,
        update_values = function(card, ability_table)
            local new = math.floor(Stacked.calc_min_max(ability_table))
            local old = ability_table.buff
            local diff = new - old

            G.GAME.extra_interest_cap = G.GAME.extra_interest_cap or 0
            G.GAME.extra_interest_cap = G.GAME.extra_interest_cap + diff

            ability_table.buff = new
        end,
        on_apply = function(card, ability_table)
            G.GAME.extra_interest_cap = G.GAME.extra_interest_cap or 0
            G.GAME.extra_interest_cap = G.GAME.extra_interest_cap + ability_table.buff
        end,
        on_remove = function(card, ability_table)
            G.GAME.extra_interest_cap = G.GAME.extra_interest_cap or 0
            G.GAME.extra_interest_cap = G.GAME.extra_interest_cap - ability_table.buff
        end,
    },
    joker_buff24 = {
        key = "joker_buff24", 
        type = "passive",
        ability = {buff = 1, min_possible = 1, max_possible = 4},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.buff, 1)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb24_potency_roll", min = 0, max = 5}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            ability_table.buff = new
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.selling_card and context.card ~= card and context.card.config and context.card.config.center and context.card.config.center.set == "Joker" then
                card.ability.extra_value = (card.ability.extra_value or 0) + Stacked.round(ability_table.buff,1)
                SMODS.calculate_effect({message = "Upgraded!"}, card)
            end
        end,
    },
    joker_buff25 = {
        key = "joker_buff25", 
        type = "passive",
        ability = {buff = 1, min_possible = 0.2, max_possible = 0.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb25_potency_roll", min = 0, max = 5}
            ability_table.buff = Stacked.round(Stacked.calc_min_max(ability_table), 1)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.round(Stacked.calc_min_max(ability_table), 1)
            local old = ability_table.buff
            local diff = new - old

            G.GAME.extra_per_interest = G.GAME.extra_per_interest or 0
            G.GAME.extra_per_interest = G.GAME.extra_per_interest - diff

            ability_table.buff = new
        end,
        on_apply = function(card, ability_table)
            G.GAME.extra_per_interest = G.GAME.extra_per_interest or 0
            G.GAME.extra_per_interest = G.GAME.extra_per_interest - ability_table.buff
        end,
        on_remove = function(card, ability_table)
            G.GAME.extra_per_interest = G.GAME.extra_per_interest or 0
            G.GAME.extra_per_interest = G.GAME.extra_per_interest + ability_table.buff
        end,
    },
    joker_buff26 = {
        key = "joker_buff26", 
        type = "attack",
        ability = {buff = 1, min_possible = 25, max_possible = 100},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb26_potency_roll", min = 0, max = 74}
            ability_table.buff = Stacked.round(Stacked.calc_min_max(ability_table), 1)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.round(Stacked.calc_min_max(ability_table), 1)
            ability_table.buff = new
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and context.cardarea == G.play then
                return{
                    mult = context.other_card:get_chip_bonus() * ability_table.buff/100
                }
            end
        end,
    },
    joker_buff27 = {
        key = "joker_buff27", 
        type = {"passive", "attack"},
        no_potency = true,
        ability = {direction = "left"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction)}}
        end,
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jb27_dir_roll"))
        end,
        change_calc_type = function(card, context, other_card, ability_table, ret, ability_index)
            local function change_effect_type(t)
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        change_effect_type(v)
                    elseif Stacked.ismult(i) or Stacked.isxmult(i) then
                        if not t.effect_type then
                            t.effect_type = {"attack"}
                        else
                            if not Stacked.t_contains(t.effect_type, "attack") then
                                t.effect_type[#t.effect_type+1] = "attack"
                            end
                        end
                    end
                end
            end

            for i,v in ipairs(G.jokers and G.jokers.cards or {}) do
                if v == card then
                    if ability_table.direction == "left" and G.jokers.cards[i-1] == other_card then
                        change_effect_type(ret)
                        break
                    elseif ability_table.direction == "right" and G.jokers.cards[i+1] == other_card then
                        change_effect_type(ret)
                        break
                    end
                end
            end
        end,
    },
    joker_buff28 = {
        key = "joker_buff28", 
        type = {"passive", "attack"},
        no_potency = true,
        ability = {direction = "left"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction)}}
        end,
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jb28_dir_roll"))
        end,
        change_calc_type = function(card, context, other_card, ability_table, ret, ability_index)
            local function change_effect_type(t)
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        change_effect_type(v)
                    elseif Stacked.ischips(i) or Stacked.isxchips(i) then
                        if not t.effect_type then
                            t.effect_type = {"attack"}
                        else
                            if not Stacked.t_contains(t.effect_type, "attack") then
                                t.effect_type[#t.effect_type+1] = "attack"
                            end
                        end
                    end
                end
            end

            for i,v in ipairs(G.jokers and G.jokers.cards or {}) do
                if v == card then
                    if ability_table.direction == "left" and G.jokers.cards[i-1] == other_card then
                        change_effect_type(ret)
                        break
                    elseif ability_table.direction == "right" and G.jokers.cards[i+1] == other_card then
                        change_effect_type(ret)
                        break
                    end
                end
            end
        end,
    },
    joker_buff29 = {
        key = "joker_buff29", 
        type = {"passive", "attack"},
        ability = {buff = 1, min_possible = 1.2, max_possible = 1.8},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb29_potency_roll", min = 0, max = 6}
            ability_table.buff = Stacked.round(Stacked.calc_min_max(ability_table), 1)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.round(Stacked.calc_min_max(ability_table), 1)
            ability_table.buff = new
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function check_type(t)
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        check_type(v)
                    elseif i == "effect_type" and Stacked.t_contains(v, "attack") then
                        for ii, vv in pairs(t) do
                            if Stacked.is_mult_or_chips(ii) then
                                if t["message"] and type(t["message"]) == "string" and string.find(t["message"], "+"..vv) then
                                    t["message"] = string.gsub(t["message"], "+"..vv, "+"..(vv * ability_table.buff))
                                end
                                t[ii] = t[ii] * ability_table.buff
                            end
                        end
                    end
                end
            end

            check_type(ret)
        end,
    },
    joker_buff30 = {
        key = "joker_buff30", 
        type = {"passive", "attack"},
        ability = {buff = 1, min_possible = 1, max_possible = 2},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, string.lower(ability_table.buff <= 1 and localize("stck_singular_times") or localize("stck_plural_times"))}}
        end,
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb30_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function check_type(t)
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        check_type(v)
                    elseif i == "effect_type" and Stacked.t_contains(v, "attack") then
                        for ii, vv in pairs(t) do
                            if Stacked.is_mult_or_chips(ii) then
                                if t["message"] and type(t["message"]) == "string" and string.find(t["message"], "+"..vv) then
                                    t["message"] = string.gsub(t["message"], "+"..vv, "+"..(vv * ability_table.buff))
                                end
                                t[ii] = t[ii] * ability_table.buff
                            end
                        end
                    end
                end
            end

            check_type(ret)
        end,
    },
    joker_buff31 = {
        key = "joker_buff31", 
        type = {"passive", "attack"},
        ability = {buff = 1, min_possible = 25, max_possible = 100},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb31_potency_roll", min = 0, max = 74}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function check_type(t)
                local chips_gain = 0

                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        check_type(v)
                    elseif i == "effect_type" and Stacked.t_contains(v, "attack") then
                        for ii, vv in pairs(t) do
                            if Stacked.ismult(ii) then
                                local exist_chips = false
                                for iii, vvv in pairs(t) do
                                    if Stacked.ischips(iii) then
                                        if t["message"] and type(t["message"]) == "string" and string.find(t["message"], "+"..vvv) then
                                            t["message"] = string.gsub(t["message"], "+"..vvv, "+"..(vvv + (vv * (ability_table.buff/100))))
                                        end
                                        t[iii] = t[iii] + (vv * (ability_table.buff/100))
                                        exist_chips = true
                                        break
                                    end
                                end
                                if not exist_chips then
                                    chips_gain = chips_gain + (vv * (ability_table.buff/100))
                                end
                            end
                        end
                    end
                end

                if chips_gain ~= 0 then
                    t["chips"] = (t["chips"] or 0) + chips_gain
                end
            end

            check_type(ret)
        end,
    },
    joker_buff32 = {
        key = "joker_buff32", 
        type = {"passive", "attack"},
        ability = {buff = 1, min_possible = 25, max_possible = 100},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb32_potency_roll", min = 0, max = 74}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function check_type(t)
                local mult_gain = 0

                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        check_type(v)
                    elseif i == "effect_type" and Stacked.t_contains(v, "attack") then
                        for ii, vv in pairs(t) do
                            if Stacked.ischips(ii) then
                                local exist_mult = false
                                for iii, vvv in pairs(t) do
                                    if Stacked.ismult(iii) then
                                        if t["message"] and type(t["message"]) == "string" and string.find(t["message"], "+"..vvv) then
                                            t["message"] = string.gsub(t["message"], "+"..vvv, "+"..(vvv + (vv * (ability_table.buff/100))))
                                        end
                                        t[iii] = t[iii] + (vv * (ability_table.buff/100))
                                        exist_mult = true
                                        break
                                    end
                                end
                                if not exist_mult then
                                    mult_gain = mult_gain + (vv * (ability_table.buff/100))
                                end
                            end
                        end
                    end
                end

                if mult_gain ~= 0 then
                    t["mult"] = (t["mult"] or 0) + mult_gain
                end
            end

            check_type(ret)
        end,
    },
    joker_buff33 = {
        key = "joker_buff33", 
        type = "passive",
        no_potency = true,
        calculate = function(card, context, ability_table, ability_index)
            if context.modify_scoring_hand and not context.blueprint then
                return {
                    add_to_hand = true
                }
            end
        end
    },
    joker_buff34 = {
        key = "joker_buff34", 
        type = {"passive", "timing"},
        no_potency = true,
        in_pool = function(card)
            return false
        end,
        change_calc_context = function(card, context, other_card, ret, ability_table, ability_index)
            if context.before and context.main_eval and card == other_card then
                return {end_of_round = true, game_over = false, beat_boss = nil}
            end
        end,
    },
    joker_buff35 = {
        key = "joker_buff35", 
        type = {"passive", "timing"},
        ability = {buff = 1, min_possible = 5, max_possible = 15, remaining = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {math.ceil(ability_table.buff), math.ceil(ability_table.remaining), string.lower(ability_table.buff <= 1 and localize("stck_singular_rounds") or localize("stck_plural_rounds"))}}
        end,
        in_pool = function(card)
            return false
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb35_potency_roll", min = 0, max = 9}
            ability_table.buff = Stacked.calc_min_max(ability_table)
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, ability_index)
            if ability_table.remaining <= 0 then
                table.remove(card.ability.hsr_extra_effects,ability_index)
            end
        end,
        change_calc_context = function(card, context, other_card, ret, ability_table, ability_index)
            if context.individual and context.cardarea == G.hand and not context.end_of_round and card == other_card then
                return {cardarea == G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true}
            end
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.end_of_round and context.main_eval and ability_table.buff > 0 then
                ability_table.buff = ability_table.buff - 1
            end
            if ability_table.buff <= 0 then
                table.remove(card.ability.hsr_extra_effects, ability_index)
            end
        end,
    },
    joker_buff36 = {
        key = "joker_buff36", 
        type = {"passive", "timing"},
        no_potency = true,
        in_pool = function(card)
            return false
        end,
        change_calc_context = function(card, context, other_card, ret, ability_table, ability_index)
            if context.individual and context.cardarea == G.hand and not context.end_of_round and card == other_card then
                return {other_card = context.other_card, full_hand = G.play.cards, scoring_hand = context.scoring_hand, cardarea = G.play, individual = true}
            end
        end
    },
    joker_buff37 = {
        key = "joker_buff37", 
        type = {"passive"},
        ability = {buff = 1, min_possible = 1.5, max_possible = 2.5, stored_mult = 0, stored_chips = 0},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {Stacked.round(ability_table.buff, 1), math.ceil(ability_table.stored_mult), math.ceil(ability_table.stored_chips)}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb37_potency_roll", min = 0, max = 10}
            ability_table.buff = Stacked.calc_min_max(ability_table)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            ability_table.buff = new
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function reduce_mult_and_chips(t)
                local remove = {}
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        reduce_mult_and_chips(v)
                    elseif Stacked.ismult(i) then
                        ability_table.stored_mult = ability_table.stored_mult + (v * ability_table.buff)
                        t[i] = 0
                        if i == "mult_mod" then remove[#remove+1] = "message" end
                    elseif Stacked.ischips(i) then
                        ability_table.stored_chips = ability_table.stored_chips + (v * ability_table.buff)
                        t[i] = 0
                        if i == "chips_mod" then remove[#remove+1] = "message" end
                    end
                end

                for _,v in ipairs(remove) do
                    t[v] = nil
                end
            end

            if other_card == card and Stacked.get_card_pos(card) ~= 1 then
                reduce_mult_and_chips(ret)
            end
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.joker_main and Stacked.get_card_pos(card) == 1 then
                local ret = {}
                if ability_table.stored_mult ~= 0 then
                    ret = SMODS.merge_effects({ret or {}, {mult = ability_table.stored_mult}})
                    ability_table.stored_mult = 0
                end
                if ability_table.stored_chips ~= 0 then
                    ret = SMODS.merge_effects({ret or {}, {chips = ability_table.stored_chips}})
                    ability_table.stored_chips = 0
                end
                return ret
            end
        end,
    },
    joker_buff38 = {
        key = "joker_buff38", 
        type = {"passive", "timing", "attack"},
        ability = {trigger_max = 3, trigger_times = 0, min_possible = 1, max_possible = 10},
        in_pool = function(card)
            if G.jokers and G.jokers.cards then
                for _,v in ipairs(G.jokers.cards) do
                    if v.ability and v.ability.hsr_extra_effects then
                        for _,vv in ipairs(v.ability.hsr_extra_effects) do
                            if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].type and Stacked.t_contains(type(ExtraEffects[vv.key].type) == "table" and ExtraEffects[vv.key].type or {ExtraEffects[vv.key].type}, "attack") then
                                return true
                            end
                        end
                    end
                end
            end
            return false
        end,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.trigger_max}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb38_potency_roll", min = 0, max = 10}
            ability_table.trigger_max = math.ceil(Stacked.calc_min_max(ability_table))
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            ability_table.trigger_max = math.ceil(new)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function follow_up(t)
                local add = false
                for i,v in pairs(t) do
                    if type(v) == "table" and i == "extra" then
                        follow_up(v)
                    elseif i == "effect_type" and Stacked.t_contains(v, "attack") and (not t.follow_card or t.follow_card ~= card) then
                        if ability_table.trigger_times < ability_table.trigger_max then
                            ability_table.trigger_times = ability_table.trigger_times + 1
                            add = true
                        end
                    end
                end

                if add then
                    if t.func then
                        local ref = t.func
                        t.func = function(...)
                            SMODS.calculate_effect({message = "Follow-up!"}, card)
                            local r = card:calculate_joker({cardarea == G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true, follow_card = card})
                            if r then
                                SMODS.calculate_effect(r, card)
                            end
                            local ref = (...)
                            return ref
                        end
                    else
                        t.func = function(...)
                            SMODS.calculate_effect({message = "Follow-up!"}, card)
                            local r = card:calculate_joker({cardarea == G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true, follow_card = card})
                            if r then
                                SMODS.calculate_effect(r, card)
                            end
                        end
                    end
                end
            end

            follow_up(ret)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.before and context.main_eval then
                ability_table.trigger_times = 0
            end
        end,
    },
    joker_buff39 = {
        key = "joker_buff39", 
        type = {"passive", "timing"},
        ability = {trigger_max = 3, trigger_times = 0, min_possible = 1, max_possible = 10, dir1 = "right", dir2 = "left"},
        in_pool = function(card)
            return false
        end,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {string.lower(localize("joker_buff14_direction_"..ability_table.dir1)), string.lower(localize("joker_buff14_direction_"..ability_table.dir2)),ability_table.trigger_max}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb39_potency_roll", min = 0, max = 10}
            ability_table.dir1 = pseudorandom_element({"right", "left"}, pseudoseed("jb39_dir"))
            ability_table.dir2 = ability_table.dir1 == "right" and "left" or "right"
            ability_table.trigger_max = math.ceil(Stacked.calc_min_max(ability_table))
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            ability_table.trigger_max = math.ceil(new)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            local function follow_up(t)
               local joker = ability_table.dir2 == "right" and G.jokers.cards[Stacked.get_card_pos(card)+1] or G.jokers.cards[Stacked.get_card_pos(card)-1]
               if joker and t and type(t) == "table" then
                    ability_table.trigger_times = ability_table.trigger_times + 1
                    local function dig(t2)
                        for i,v in pairs(t2) do
                            if i == "extra" and type(v) == "table" then
                                dig(v)
                                return
                            end
                        end

                        if not t2.func then
                            t2.func = function(...)
                                SMODS.calculate_effect({message = "Dance!"}, joker)
                                SMODS.calculate_effect(joker:calculate_joker({cardarea == G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true, dance_card = card}) or {}, joker)
                            end
                        else
                            local ref = t2.func
                            t2.func = function(...)
                                SMODS.calculate_effect({message = "Dance!"}, joker)
                                SMODS.calculate_effect(joker:calculate_joker({cardarea == G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true, dance_card = card}) or {}, joker)
                                local ret = ref(...)
                                return ret
                            end
                        end
                        return
                    end

                    dig(t)
               end
            end

            if (ability_table.dir1 == "right" and other_card == G.jokers.cards[Stacked.get_card_pos(card)+1]) or (ability_table.dir1 == "left" and other_card == G.jokers.cards[Stacked.get_card_pos(card)-1]) and (not context.dance_card or context.dance_card ~= card) and ability_table.trigger_times < ability_table.trigger_max then
                follow_up(ret)
            end
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.before and context.main_eval then
                ability_table.trigger_times = 0
            end
        end,
    },
    joker_buff40 = {
        key = "joker_buff40", 
        type = {"passive", "timing"},
        ability = {trigger_max = 1, min_possible = 1, max_possible = 10},
        in_pool = function(card)
            return false
        end,
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.trigger_max}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb40_potency_roll", min = 0, max = 10}
            ability_table.trigger_max = math.ceil(Stacked.calc_min_max(ability_table))
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            ability_table.trigger_max = math.ceil(new)
        end,
        modify_calculate = function(card, context, other_card, ability_table, ret, ability_index)
            if context.joker_main and Stacked.get_card_pos(other_card) <= ability_table.trigger_max and (not context.last_push_card or context.last_push_card ~= card) then
                SMODS.calculate_effect({message = "Last Push!"}, other_card)
                ret = SMODS.merge_effects({ret or {}, other_card:calculate_joker({cardarea == G.jokers, full_hand = G.play.cards, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands, joker_main = true, last_push_card = card}) or {}})
            end
        end,
    },
    joker_buff41 = {
        key = "joker_buff41", 
        type = {"passive"},
        ability = {buff = 1, min_possible = 1, max_possible = 3, stored_mult = 0, stored_chips = 0},
        loc_vars = function(info_queue, card, ability_table)
            local loc_key = nil
            if ability_table.perfect and ability_table.perfect >= 100 then
                loc_key = "joker_buff41_2"
            end
            return {key = loc_key, vars = {ability_table.buff, ability_table.buff == 1 and string.lower(localize("stck_singular_cards")) or string.lower(localize("stck_plural_cards"))}}
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jb41_potency_roll", min = 0, max = 10}
            ability_table.buff = math.floor(Stacked.calc_min_max(ability_table))
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            ability_table.buff = math.floor(new)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.force_scoring_hand then
                local dupe_hand = {}
                for _,v in ipairs(G.hand.cards) do
                    table.insert(dupe_hand, v)
                end

                local run = 0
                for _,v in ipairs(dupe_hand) do
                    G.hand:remove_card(v)
                    G.play:emplace(v)
                    run = run + 1
                    if ability_table.perfect >= 100 then
                        v.jb41_always_score = true
                    end
                    if run >= ability_table.buff then break end
                end

                local scoring_hand = nil
                local poker_hands = evaluate_poker_hand(G.play.cards)
                for _, v in ipairs(G.handlist) do
                    if next(poker_hands[v]) then
                        scoring_hand = poker_hands[v][1]
                        break
                    end
                end

                return{
                    change_scoring_hand = scoring_hand
                }
            end
            if context.modify_scoring_hand and not context.blueprint and ability_table.perfect >= 100 and context.other_card.jb41_always_score then
                context.other_card.jb41_always_score = nil
                return {
                    add_to_hand = true
                }
            end
        end,
    },

    joker_curse1 = {
        key = "joker_curse1", 
        type = {"passive", "cursed"},
        ability = {buff = 1, min_possible = 0.2, max_possible = 0.5},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff}}
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jc1_potency_roll", min = 0, max = 5}
            ability_table.buff = Stacked.round(Stacked.calc_min_max(ability_table), 1)
        end,
        update_values = function(card, ability_table)
            local new = Stacked.round(Stacked.calc_min_max(ability_table), 1)
            local old = ability_table.buff
            local diff = new - old

            G.GAME.extra_per_interest = G.GAME.extra_per_interest or 0
            G.GAME.extra_per_interest = G.GAME.extra_per_interest + diff

            ability_table.buff = new
        end,
        on_apply = function(card, ability_table)
            G.GAME.extra_per_interest = G.GAME.extra_per_interest or 0
            G.GAME.extra_per_interest = G.GAME.extra_per_interest + ability_table.buff
        end,
        on_remove = function(card, ability_table)
            G.GAME.extra_per_interest = G.GAME.extra_per_interest or 0
            G.GAME.extra_per_interest = G.GAME.extra_per_interest - ability_table.buff
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.end_of_round and context.main_eval then
                return{
                    dollars = 2
                }
            end
        end,
    },
    joker_curse2 = {
        key = "joker_curse2", 
        type = {"passive", "cursed"},
        no_potency = true,
        ability = {direction = "left"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("joker_buff14_direction_"..ability_table.direction)}}
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jc2_dir_roll"))
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.before and context.main_eval then
                local pos = Stacked.get_card_pos(card)
                local other_joker = ability_table.direction == "left" and G.jokers.cards[pos-1] or G.jokers.cards[pos+1]
                if other_joker then
                    SMODS.debuff_card(other_joker, true, "joker_curse2")
                end
            end
            if context.after then
                local pos = Stacked.get_card_pos(card)
                local other_joker = ability_table.direction == "left" and G.jokers.cards[pos-1] or G.jokers.cards[pos+1]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if other_joker then
                            SMODS.debuff_card(other_joker, false, "joker_curse2")
                        end
                        return true
                    end
                }))
            end
            if context.joker_buff then
                return{
                    buff = 1.5
                }
            end
        end,
    },
    joker_curse3 = {
        key = "joker_curse3", 
        type = {"passive", "cursed"},
        no_potency = true,
        ability = {direction = "left"},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {localize("stck_most_"..ability_table.direction), ability_table.direction == "left" and localize("stck_most_right") or localize("stck_most_left")}}
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        randomize_values = function(card, ability_table)
            ability_table.direction = pseudorandom_element({"left", "right"}, pseudoseed("jc3_dir_roll"))
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.before and context.main_eval and context.scoring_hand and #context.scoring_hand >= 2 then
                SMODS.debuff_card(ability_table.direction == "left" and context.scoring_hand[1] or context.scoring_hand[#context.scoring_hand], true, "joker_curse3")
            end
            if context.after then
                local scoring_hand = context.scoring_hand
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if scoring_hand then
                            SMODS.debuff_card(ability_table.direction == "left" and scoring_hand[1] or scoring_hand[#scoring_hand], false, "joker_curse3")
                        end
                        return true
                    end
                }))
            end
            if context.repetition and context.cardarea == G.play and context.scoring_hand and #context.scoring_hand >= 2 then
                if (ability_table.direction == "left" and context.other_card == context.scoring_hand[#context.scoring_hand]) or (ability_table.direction == "right" and context.other_card == context.scoring_hand[1]) then
                    return{
                        repetitions = 1
                    }
                end
            end
        end,
    },
    joker_curse4 = {
        key = "joker_curse4", 
        type = {"attack", "cursed"},
        ability = {suit1 = "Hearts", suit2 = "Clubs", buff1 = 1, buff2 = 1, min_possible = 5, max_possible = 15},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.suit1, ability_table.buff1, ability_table.suit2, ability_table.buff2, colours = {G.C.SUITS[ability_table.suit1], G.C.SUITS[ability_table.suit2]}}}
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        randomize_values = function(card, ability_table)
            local suits = {"Spades", "Hearts", "Clubs", "Diamonds"}
            ability_table.suit1 = pseudorandom_element(suits, pseudoseed(card.config.center.key.."jc4_randomize"))
            for i,v in ipairs(suits) do
                if v == ability_table.suit1 then table.remove(suits,i); break end
            end
            ability_table.suit2 = pseudorandom_element(suits, pseudoseed(card.config.center.key.."jc4_randomize"))
            ability_table.perfect = Stacked.poll_potency{seed = "jc4_potency_roll", min = 0, max = 10}
            ability_table.buff1 = math.ceil(Stacked.calc_min_max(ability_table))
            ability_table.buff2 = math.ceil(Stacked.calc_min_max(ability_table) * 1.5)
        end,
        update_values = function(card, ability_table)
            ability_table.buff1 = math.ceil(Stacked.calc_min_max(ability_table))
            ability_table.buff2 = math.ceil(Stacked.calc_min_max(ability_table) * 1.5)
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit(ability_table.suit1) then
                    return{
                        mult = -ability_table.buff1
                    }
                end 
                if context.other_card:is_suit(ability_table.suit2) then
                    return{
                        mult = ability_table.buff2
                    }
                end 
            end 
        end,
    },
    joker_curse5 = {
        key = "joker_curse5", 
        type = {"passive", "cursed"},
        no_potency = true,
        ability = {used_tarot = true},
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        update_values = function(card, ability_table)
            if not card.debuff and not ability_table.used_tarot then
                SMODS.debuff_card(card, true, "joker_curse5")
            end
            if card.debuff and ability_table.used_tarot then
                SMODS.debuff_card(card, false, "joker_curse5")
            end
        end,
        calculate = function(card, context, ability_table, ability_index)
            if context.end_of_round and context.main_eval then
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    SMODS.add_card{set = "Tarot"}
                end
                ability_table.used_tarot = false
            end
        end,
    },
    joker_curse6 = {
        key = "joker_curse6", 
        type = {"passive", "cursed"},
        no_potency = true,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        on_apply = function(...)
            G.GAME.win_ante = G.GAME.win_ante + 1
            if G.GAME.blind and G.GAME.blind.in_blind then
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - (20/100))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end,
        on_remove = function(...)
            G.GAME.win_ante = G.GAME.win_ante - 1
            if G.GAME.blind and G.GAME.blind.in_blind then
                G.GAME.blind.chips = G.GAME.blind.chips / (1 - (20/100))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end,
        calculate = function(card, context, ability_table)
            if context.setting_blind then
                G.GAME.blind.chips = G.GAME.blind.chips * (1 - (20/100))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end,
    },
    joker_curse7 = {
        key = "joker_curse7", 
        type = {"passive", "cursed"},
        no_potency = true,
        prevent_sold = true,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        calculate = function(card, context, ability_table)
            if context.end_of_round and context.main_eval then
                card.sell_cost = card.sell_cost + 3
            end
        end,
    },
    joker_curse8 = {
        key = "joker_curse8", 
        type = {"passive", "cursed"},
        ability = {buff = 1, min_possible = 1, max_possible = 2, remaining = 1},
        loc_vars = function(info_queue, card, ability_table)
            return {vars = {ability_table.buff, math.ceil(ability_table.remaining), string.lower(ability_table.buff <= 1 and localize("stck_singular_times") or localize("stck_plural_times"))}}
        end,
        in_pool = function(card)
            return not not G.GAME.cursed_effects_enable
        end,
        randomize_values = function(card, ability_table)
            ability_table.perfect = Stacked.poll_potency{seed = "jc8_potency_roll", min = 0, max = 1}
            ability_table.buff = Stacked.calc_min_max(ability_table)
            ability_table.remaining = ability_table.buff
        end,
        update_values = function(card, ability_table)
            local new = Stacked.calc_min_max(ability_table)
            local old = ability_table.buff
            local diff = new - old
            ability_table.buff = new
            ability_table.remaining = ability_table.remaining + diff
        end,
        on_apply = function(card, ability_table, ability_index)
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
                card:juice_up()
                card:set_ability(pseudorandom_element(Stacked.get_similar_pool(G.P_CENTER_POOLS.Joker,{rarity = card.config.center.rarity}), pseudoseed(card.config.center.key.."_jc8_roll")).key)
                return{
                    block = true
                }
            end
        end,
    },
}