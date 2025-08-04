--eval apply_extra_effect(G.jokers.cards[1], "score_suit_mult")
function apply_extra_effect(card, effect, bypass_cap)
    card.ability.hsr_extra_effects = card.ability.hsr_extra_effects or {}
    if not effect then
        local pool = {}
        for i,v in pairs(ExtraEffects) do
            if v.in_pool and type(v.in_pool) == "function" then
                if v.in_pool(card) then
                    pool[#pool+1] = i
                end
            else
                pool[#pool+1] = i
            end
        end
        if #pool > 0 then
            local random_effect = pseudorandom_element(pool, pseudoseed(card.config.center.key.."_roll_effect_seed"))
            if random_effect then
                effect = random_effect
            end
        end
    end
    if ExtraEffects[effect] and (bypass_cap or (#card.ability.hsr_extra_effects < (G.GAME.hsr_maximum_extra_effects or 2))) then
        local new_effect = table.clone(ExtraEffects[effect])
        local desc = (G.localization.ExtraEffects and G.localization.ExtraEffects[effect]) or new_effect.description or (G.localization.ExtraEffects and G.localization.ExtraEffects["joker_youforgotyourfuckingdescription"])
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

function Card:apply_extra_effect(effect, bypass_cap)
    if self.ability and self.config and self.config.center and self.config.center.set == "Joker" then
        apply_extra_effect(self, effect, bypass_cap)
    end
end

function Stacked.poll_potency(args)
    local args = args or {}
    args.round = args.round or 1
    args.seed = args.seed or "stacked_poll_potency"
    args.unaff_cap = args.unaff_cap or false
    local default_args_max = args.max or 10
    args.max = Stacked.round((args.max or 10) * (((args.unaff_cap and 100) or G.GAME.hsr_potency_cap or 100) / 100), 0)
    args.min = args.min or 0
    
    local potency_roll = Stacked.round(pseudorandom(args.seed, args.min, args.max) * (100/default_args_max), args.round)

    return math.min((G.GAME.hsr_min_potency and math.max(potency_roll, G.GAME.hsr_min_potency)) or potency_roll, ((args.unaff_cap and 100) or G.GAME.hsr_potency_cap or 100))
end