SMODS.Atlas ({
    key = 'anvil',
    path = 'anvil.png',
    px = 71,
    py = 95,
})

SMODS.Consumable {
    key = 'anvil',
    set = 'Spectral',
    atlas = 'anvil',
    config = { extra = { potency = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.potency, G.GAME.hsr_potency_cap or 100 } }
    end,
    use = function(self, card, area, copier)
        local joker_pool = {}
            for i,v in ipairs(G.jokers.cards) do
                if v.ability.hsr_extra_effects then
                    for _,vv in ipairs(v.ability.hsr_extra_effects) do
                        if vv.ability and vv.ability.perfect and vv.ability.perfect < G.GAME.hsr_potency_cap or 100 then
                            joker_pool[#joker_pool+1] = v
                            break
                        end
                    end
                end
            end
        local random_joker = pseudorandom_element(joker_pool, pseudoseed("stck_anvil"))
        local pool = {}
        for i,v in ipairs(random_joker.ability.hsr_extra_effects) do
            if v.ability and v.ability.perfect then pool[#pool+1] = v end
        end
        local random = pseudorandom_element(pool, pseudoseed("stck_anvil"))
        if random and random.ability and random.ability.perfect and random.ability.perfect < G.GAME.hsr_potency_cap or 100 then
            random.ability.perfect = math.min(random.ability.perfect + card.ability.extra.potency, G.GAME.hsr_potency_cap or 100)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        local joker_test = false
        for i,v in ipairs(G.jokers.cards) do
            if v.ability.hsr_extra_effects then
                for _,vv in ipairs(v.ability.hsr_extra_effects) do
                    if vv.ability and vv.ability.perfect and vv.ability.perfect < G.GAME.hsr_potency_cap or 100 then
                        joker_test = true
                        break
                    end
                end
            end
        end
        return joker_test
    end
}

SMODS.Atlas ({
    key = 'distort',
    path = 'distort.png',
    px = 71,
    py = 95,
})

SMODS.Consumable {
    key = 'distort',
    set = 'Spectral',
    soul_set = "Tarot",
    atlas = 'distort',
    soul_pos = {x = 1, y = 0},
    use = function(self, card, area, copier)
        if G.jokers and G.jokers.highlighted then
            if #G.jokers.highlighted > 0 then
                local joker = G.jokers.highlighted[1]
                if joker.ability then
                    if not joker.ability.hsr_extra_effects or #joker.ability.hsr_extra_effects < (G.GAME.hsr_maximum_extra_effects or 2) then
                        joker:apply_random_effect("timing", joker.config.center.key.."_stck_distort", false, true)
                    end
                end
            end
        end
    end,
    can_use = function(self, card)
        if G.jokers and G.jokers.highlighted then
            if #G.jokers.highlighted > 0 then
                local joker = G.jokers.highlighted[1]
                if joker.ability then
                    if not joker.ability.hsr_extra_effects or #joker.ability.hsr_extra_effects < (G.GAME.hsr_maximum_extra_effects or 2) then
                        return true
                    end
                end
            end
        end
    end
}