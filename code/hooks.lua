--"Borrowed" from TheAutumnCircus, thanks!
local alias__SMODS_get_probability_vars = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll)
	local probvars = {alias__SMODS_get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll)}
	
    if not G.jokers then return probvars[1], probvars[2] end
	if trigger_obj and trigger_obj.config and trigger_obj.config.center and trigger_obj.config.center.set and trigger_obj.config.center.set == "Joker" then
        if trigger_obj.ability and trigger_obj.ability.hsr_extra_effects then
            for i,v in ipairs(trigger_obj.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].probability_vars and type(ExtraEffects[v.key].probability_vars) == "function" then
                    local ret = ExtraEffects[v.key].probability_vars(trigger_obj, v.ability, probvars, i)
                    if ret then
                        probvars[1] = ret[1]
                        probvars[2] = ret[2]
                    end
                end
            end
        end
	end
	
	return probvars[1], probvars[2]
end

stck_hoveredCard = nil
local ref = Card.hover
function Card:hover()
    if self.hsr_changing_page then self.hsr_changing_page = nil end
    stck_hoveredCard = self
    local ret = ref(self)
    return ret
end

local ref = Card.stop_hover
function Card:stop_hover()
    if stck_hoveredCard == self and not self.hsr_changing_page then
        stck_hoveredCard = nil
    end
    local ret = ref(self)
    return ret
end

--:stop_hover()
local hookTo = love.wheelmoved 
function love.wheelmoved(x, y)
    if y > 0 then
        --text = "Mouse wheel moved up"
        if stck_hoveredCard and stck_hoveredCard.ability and stck_hoveredCard.ability.hsr_extra_effects and #stck_hoveredCard.ability.hsr_extra_effects > Stacked.effect_per_page then
            stck_hoveredCard.hsr_effect_page = stck_hoveredCard.hsr_effect_page or 1
            stck_hoveredCard.hsr_effect_page = stck_hoveredCard.hsr_effect_page - 1
            if stck_hoveredCard.hsr_effect_page <= 1 then stck_hoveredCard.hsr_effect_page = 1 end
            stck_hoveredCard.hsr_changing_page = true
            stck_hoveredCard:stop_hover()
            stck_hoveredCard:hover()
        end
    elseif y < 0 then
        --text = "Mouse wheel moved down"
        if stck_hoveredCard and stck_hoveredCard.ability and stck_hoveredCard.ability.hsr_extra_effects and #stck_hoveredCard.ability.hsr_extra_effects > Stacked.effect_per_page then
            stck_hoveredCard.hsr_effect_page = stck_hoveredCard.hsr_effect_page or 1
            stck_hoveredCard.hsr_effect_page = math.min(stck_hoveredCard.hsr_effect_page + 1, math.ceil(#stck_hoveredCard.ability.hsr_extra_effects/Stacked.effect_per_page))
            stck_hoveredCard.hsr_changing_page = true
            stck_hoveredCard:stop_hover()
            stck_hoveredCard:hover()
        end
    end
    local ret = hookTo(x, y)
    return ret
end

local hookTo = Game.start_run
function Game:start_run(...)
    local ret = hookTo(self,...)
    self.GAME.hsr_extra_chance_rate = self.GAME.hsr_extra_chance_rate or 5
    self.GAME.hsr_maximum_extra_effects = self.GAME.hsr_maximum_extra_effects or 2
    self.GAME.hsr_potency_cap = self.GAME.hsr_potency_cap or 100
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

            for i,v in ipairs(card.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].detect_value_change and type(ExtraEffects[v.key].detect_value_change) == "function" then
                    local function check_change(t,ref)
                        for ii,vv in pairs(t) do
                            if type(vv) == "table" then
                                ref[ii] = ref[ii] or {}
                                check_change(vv,ref[ii])
                            elseif type(vv) == "number" and ref[ii] and type(ref[ii]) == "number" and vv ~= ref[ii] then
                                local diff = vv - ref[ii]
                                ExtraEffects[v.key].detect_value_change(card, v.ability, diff, i, ii)
                            end
                        end
                    end

                    for _,joker in ipairs(G.jokers.cards) do
                        joker.hsr_old_ability = joker.hsr_old_ability or {}
                        check_change(joker.ability, joker.hsr_old_ability)
                        local clone = table.clone(joker.ability)
                        if joker.hsr_old_ability then joker.hsr_old_ability = nil end
                        joker.hsr_old_ability = clone
                    end
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
    card.hsr_old_cardarea = card.area
    card.hsr_is_destroyed_perhaps = false
    local ret = hookTo(self, card, location, stay_flipped)
    if self == G.jokers then
        if card.ability and card.ability.hsr_extra_effects then
            for i,v in ipairs(card.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].on_apply and type(ExtraEffects[v.key].on_apply) == "function" then
                    ExtraEffects[v.key].on_apply(card, v.ability, i)
                    v.ability.on_apply_flagged = true
                end
            end
        end
    end
    return ret
end

local hookTo = CardArea.remove_card
function CardArea:remove_card(card, discarded_only)
    if card and type(card) == "table" then
        card.hsr_old_cardarea = card.area
        card.hsr_is_destroyed_perhaps = true
    end
    local ret = hookTo(self, card, discarded_only)
    return ret
end

local hookTo = Card.remove
function Card:remove()
    if Stacked.is_food_joker(self) or (self.config.center.pools and self.config.center.pools.Food) then 
        if self.ability and self.ability.hsr_extra_effects and (self.area == G.jokers or (self.hsr_old_cardarea == G.jokers and self.hsr_is_destroyed_perhaps)) then
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
        else
            for _,v in ipairs(G.jokers and G.jokers.cards or {}) do
                if v.ability and v.ability.hsr_extra_effects then
                    for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                        if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].prevent_other_destruction and type(ExtraEffects[vv.key].prevent_other_destruction) == "function" then
                            local pod = ExtraEffects[vv.key].prevent_other_destruction(v, vv.ability, self, ii)
                            if pod and pod.block then
                                return
                            end
                        end
                    end
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
    else
        for _,v in ipairs(G.jokers and G.jokers.cards or {}) do
            if v.ability and v.ability.hsr_extra_effects then
                for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                    if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].prevent_other_destruction and type(ExtraEffects[vv.key].prevent_other_destruction) == "function" then
                        local pod = ExtraEffects[vv.key].prevent_other_destruction(v, vv.ability, self, ii)
                        if pod and pod.block then
                            return
                        end
                    end
                end
            end
        end
    end
    local ret = hookTo(self,...)
    return ret
end

local hookTo = SMODS.showman
function SMODS.showman(card_key)
    local ret = hookTo(card_key)
    if not ret then
        for _,v in ipairs(G.jokers and G.jokers.cards or {}) do
            if v.ability and v.ability.hsr_extra_effects then
                for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                    if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].check_showman and type(ExtraEffects[vv.key].check_showman) == "function" then
                        local new_ret =  ExtraEffects[vv.key].check_showman(v, vv.ability, card_key, ii)
                        if new_ret then return new_ret end
                    end
                end
            end
        end
    end
    return ret
end

local hookTo = Card.calculate_joker
function Card:calculate_joker(context)
    local o, t = hookTo(self, context)
    local ret = o
    if context and type(context) == "table" and context.follow_card then
		ret = ret or {}
        ret.follow_card = context.follow_card
    end
    if context and type(context) == "table" and context.hsr_change_context then
        return ret, t
    end

    local function table_count(t)
        local i = 0
        for _,_ in pairs(t) do
            i = i + 1
        end
        return i
    end

    for _,v in ipairs(G.jokers.cards) do
        if v.ability and v.ability.hsr_extra_effects then
            for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].change_calc_context and type(ExtraEffects[vv.key].change_calc_context) == "function" then
                    local new_contexts = ExtraEffects[vv.key].change_calc_context(v, context, self, ret, vv.ability, ii)
                    if new_contexts and type(new_contexts) == "table" and table_count(new_contexts) > 0 and (not self.config.center.avoid_contexts or not Stacked.equal(new_contexts, self.config.center.avoid_contexts)) then
                        new_contexts.hsr_change_context = true
                        local o2, t2 = hookTo(self, new_contexts)
                        ret = SMODS.merge_effects({ret or {}, o2 or {}})
                    end
                end
            end
        end
    end
    
    if self.ability and self.ability.hsr_extra_effects then
        for i,v in ipairs(self.ability.hsr_extra_effects) do
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].calculate and type(ExtraEffects[v.key].calculate) == "function" then
                local calc = ExtraEffects[v.key].calculate(self, context, v.ability, i)
                if calc and v.key and ExtraEffects[v.key] and ExtraEffects[v.key] and ExtraEffects[v.key].type then
                    calc.effect_type = type(ExtraEffects[v.key].type) == "table" and ExtraEffects[v.key].type or {ExtraEffects[v.key].type}
                end
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
                            recursive_check(vv)
                        end
                    end
                end
                if ret then
                    recursive_check(ret)
                end
            end
        end
    end

    if ret and type(ret) == "table" and table_count(ret) >= 1 then
        for _,v in ipairs(G.jokers.cards) do
            if v.ability and v.ability.hsr_extra_effects then
                for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                    if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].change_calc_type and type(ExtraEffects[vv.key].change_calc_type) == "function" then
                        ExtraEffects[vv.key].change_calc_type(v, context, self, vv.ability, ret, ii)
                    end
                end
            end
        end
        
        for _,v in ipairs(G.jokers.cards) do
            if v.ability and v.ability.hsr_extra_effects then
                for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                    if vv.key and ExtraEffects[vv.key] and ExtraEffects[vv.key].modify_calculate and type(ExtraEffects[vv.key].modify_calculate) == "function" then
                        ExtraEffects[vv.key].modify_calculate(v, context, self, vv.ability, ret, ii)
                    end
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

    if self.config.center.set == "Joker" and not G.OVERLAY_MENU and G.STAGE == G.STAGES.RUN then
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

local hookTo = desc_from_rows
function desc_from_rows(desc_nodes, empty, maxw)
    local ret = hookTo(desc_nodes, empty, maxw)

    if desc_nodes.hsr_box_minh then
        ret = {}
        local t = {}
        for k, v in ipairs(desc_nodes) do
            t[#t+1] = {n=G.UIT.R, config={align = "cm", maxw = maxw}, nodes=v}
        end
        ret = {n=G.UIT.R, config={align = "cm", colour = desc_nodes.background_colour or empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE, r = 0.1, padding = 0.04, minw = 2, minh = desc_nodes.hsr_box_minh, emboss = not empty and 0.05 or nil, filler = true, main_box_flag = desc_nodes.main_box_flag and true or nil}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}
        }}
    end

    if desc_nodes.is_effect_box then
        ret = {}
        local t = {}
        for k, v in ipairs(desc_nodes) do
            t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
        end

        local name_nodes = {n=G.UIT.R, config={align = "tm", minh = 0.36, padding = 0.03}, nodes={{n=G.UIT.T, config={text = "No Name", scale = 0.32, colour = desc_nodes.main_name_colour or G.C.UI.TEXT_LIGHT}}}}

        if desc_nodes.effect_name then
            local n = {}
            local n2 = {}
            local args = {text_colour = desc_nodes.main_name_colour or G.C.UI.TEXT_LIGHT, shadow = true}
            for i,v in pairs(desc_nodes.effect_name_vars or {}) do
                args[i] = v
            end
            for j, line in ipairs(desc_nodes.effect_name) do
                n[#n+1] = Stacked.stacked_localize_box(line, args)
            end

            for k, v in ipairs(n) do
                n2[#n2+1] = {n=G.UIT.R, config= {align = "cm"}, nodes=v}
            end
            name_nodes = {n=G.UIT.R, config = {align = "cm", minh = 0.36}, nodes = n2}
        end

        local type_nodes = {}

        if desc_nodes.effect_types then
            local n = {}
            local n2 = {}
            local parsed = {}
            local vars = {}
            for _,v in ipairs(desc_nodes.effect_types) do
                if #parsed <= 0 then
                    parsed = Stacked.manual_parse(G.localization.ExtraEffectTypes[v] or "TYPE LOC FAILED")
                else
                    for _,vv in ipairs(Stacked.manual_parse("/")[1]) do
                        parsed[1][#parsed[1]+1] = vv
                    end
                    for _,vv in ipairs(Stacked.manual_parse(G.localization.ExtraEffectTypes[v] or "TYPE LOC FAILED")[1]) do
                        parsed[1][#parsed[1]+1] = vv
                    end
                end
            end
            if desc_nodes.potency then
                if #parsed <= 0 then
                    parsed = Stacked.manual_parse(G.localization.ExtraEffectTypes["potency"] or "TYPE LOC FAILED")
                else
                    for _,vv in ipairs(Stacked.manual_parse(" - ")[1]) do
                        parsed[1][#parsed[1]+1] = vv
                    end
                    for _,vv in ipairs(Stacked.manual_parse(G.localization.ExtraEffectTypes["potency"] or "TYPE LOC FAILED")[1]) do
                        parsed[1][#parsed[1]+1] = vv
                    end
                end
                vars[#vars+1] = desc_nodes.potency
                vars.colours = vars.colours or {}
                vars.colours[#vars.colours+1] = lighten({1 - (1 * desc_nodes.potency/100), 1 * desc_nodes.potency/100, 0, 1}, 0.5)
            end
            --test: eval G.jokers.cards[1]:apply_extra_effect("score_suit_mult")

            for j, line in ipairs(parsed) do
                n[#n+1] = Stacked.stacked_localize_box(line, {text_colour = desc_nodes.name_colour or G.C.UI.TEXT_LIGHT, shadow = true, fixed_scale = 0.7, vars = vars})
            end

            for k,v in ipairs(n) do
                n2[#n2+1] = {n = G.UIT.R, config = {align = "cm"}, nodes = v}
            end

            type_nodes = {n=G.UIT.R, config = {align = "cm", minh = 0.15}, nodes = n2}
        end

        ret = {n=G.UIT.R, config={align = "cm", colour = desc_nodes.name_background_colour or lighten(G.C.GREY, 0.15), r = 0.1}, nodes={
            name_nodes,
            type_nodes,
            {n=G.UIT.R, config = {align = "cm", minh = 0.05}},
            {n=G.UIT.R, config={align = "cm", minw = 2, minh = 0.4, r = 0.1, padding = 0.05, colour = desc_nodes.background_colour or empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE, id = "stacked_effect_box"..desc_nodes.box_num}, nodes={{n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes = t}}}
        }}
    end

    return ret
end

local hookTo = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table(...)
    local ret = hookTo(self,...)
    if self.ability and self.ability.hsr_extra_effects and #self.ability.hsr_extra_effects > 0 then
        ret.multi_box = ret.multi_box or {}
        local existing_mb = #ret.multi_box
        local effect_amt = #self.ability.hsr_extra_effects
        local increase = 0
        local type_shi = 0
        ret.box_colours = ret.box_colours or {}
        ret.main = ret.main or {}
        ret.main.main_box_flag = true

        local function create_simple_box(line, vars, args)
            local final_line = Stacked.stacked_localize_box(line, vars)
            ret.multi_box[existing_mb + increase] = ret.multi_box[existing_mb + increase] or {}
            ret.multi_box[existing_mb + increase][#ret.multi_box[existing_mb + increase]+1] = final_line
            ret.multi_box[existing_mb + increase]["hsr_box_minh"] = 0
            ret.box_colours[existing_mb + increase + 1] = G.C.CLEAR

            return final_line
        end

        local function simplified_box(desc, vars, args)
            local desc = table.clone(desc)
            desc.text = {desc.text}
            desc = Stacked.manual_parse(desc)
            increase = increase + 1
            for i, box in ipairs(desc.text_parsed) do
                for j, line in ipairs(box) do
                    create_simple_box(line, vars, args)
                end
            end
        end

        local function create_effect_box(v, i, desc, line, loc_vars)
            ret.multi_box[existing_mb + increase] = ret.multi_box[existing_mb + increase] or {}
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].type then
                if Stacked.t_contains((type(ExtraEffects[v.key].type) == "table" and ExtraEffects[v.key].type) or {ExtraEffects[v.key].type}, "cursed") then
                    ret.multi_box[existing_mb + increase]["main_name_colour"] = SMODS.Gradients["stck_cursed"]
                elseif Stacked.t_contains((type(ExtraEffects[v.key].type) == "table" and ExtraEffects[v.key].type) or {ExtraEffects[v.key].type}, "timing") then
                    ret.multi_box[existing_mb + increase]["main_name_colour"] = SMODS.Gradients["stck_rainbow"]
                end
            end 
            local final_line = SMODS.localize_box(line, loc_vars)
            ret.multi_box[existing_mb + increase][#ret.multi_box[existing_mb + increase]+1] = final_line
            ret.multi_box[existing_mb + increase]["is_effect_box"] = true
            ret.multi_box[existing_mb + increase]["effect_name"] = desc.name_parsed or {}
            ret.multi_box[existing_mb + increase]["box_num"] = type_shi
            ret.multi_box[existing_mb + increase]["effect_types"] = (v.key and ExtraEffects[v.key] and ExtraEffects[v.key].type and ((type(ExtraEffects[v.key].type) == "table" and ExtraEffects[v.key].type) or {ExtraEffects[v.key].type}))
            ret.multi_box[existing_mb + increase]["effect_name_vars"] = loc_vars
            if v.key and ExtraEffects[v.key] and not ExtraEffects[v.key].no_potency then
                ret.multi_box[existing_mb + increase]["potency"] = v.ability.perfect
            end
            if not next(ret.info) then ret.box_colours[i] = G.C.UI.BACKGROUND_WHITE end
            if loc_vars.background_colour then
                ret.box_colours[existing_mb + increase + 1] = loc_vars.background_colour
            end
            if loc_vars.main_name_colour then
                ret.multi_box[existing_mb + increase]["main_name_colour"] = loc_vars.main_name_colour
            end
            if loc_vars.name_background_colour then
                ret.multi_box[existing_mb + increase]["name_background_colour"] = loc_vars.name_background_colour
            end

            return final_line
        end

        if effect_amt <= Stacked.effect_per_page then
            simplified_box(G.localization.ExtraEffects.joker_effect_separator, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})

            if not G.hsr_hide_effects then
                for _,v in ipairs(self.ability.hsr_extra_effects) do
                    local desc = v.description
                    if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].loc_vars and ExtraEffects[v.key].loc_vars({}, self, v.ability) then
                        local loc_key = ExtraEffects[v.key].loc_vars({}, self, v.ability).key
                        if loc_key then
                            if G.localization.ExtraEffects and G.localization.ExtraEffects[loc_key] then
                                desc = G.localization.ExtraEffects[loc_key]
                            elseif ExtraEffects[loc_key] and ExtraEffects[loc_key].description then
                                desc = ExtraEffects[loc_key].description
                            end
                            desc = table.clone(desc)
                            desc.text = {desc.text}
                            desc = Stacked.manual_parse(desc)
                        end
                    end
                    type_shi = type_shi + 1
                    increase = increase + 1
                    for i, box in ipairs(desc.text_parsed) do
                        for j, line in ipairs(box) do
                            local loc_vars = (v.key and ExtraEffects[v.key] and ExtraEffects[v.key].loc_vars and ExtraEffects[v.key].loc_vars({}, self, v.ability)) or {}
                            create_effect_box(v, i, desc, line, loc_vars)
                        end
                    end
                end
            end

            if not G.hsr_hide_effects then
                simplified_box(G.localization.ExtraEffects.joker_effect_hide, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})
            else
                simplified_box(G.localization.ExtraEffects.joker_effect_show, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})
            end
        else
            self.hsr_effect_page = self.hsr_effect_page or 1
            local max_pages = math.ceil(effect_amt/Stacked.effect_per_page)
            self.hsr_effect_page = math.min(self.hsr_effect_page, max_pages)
            local current_page = self.hsr_effect_page

            simplified_box(G.localization.ExtraEffects.joker_effect_separator, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})

            if not G.hsr_hide_effects then
                for i = 1 + (Stacked.effect_per_page * (current_page - 1)), Stacked.effect_per_page + (Stacked.effect_per_page * (current_page - 1)) do
                    if self.ability.hsr_extra_effects[i] then
                        local v = self.ability.hsr_extra_effects[i]
                        local desc = v.description
                        if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].loc_vars and ExtraEffects[v.key].loc_vars({}, self, v.ability) then
                            local loc_key = ExtraEffects[v.key].loc_vars({}, self, v.ability).key
                            if loc_key then
                                if G.localization.ExtraEffects and G.localization.ExtraEffects[loc_key] then
                                    desc = G.localization.ExtraEffects[loc_key]
                                elseif ExtraEffects[loc_key] and ExtraEffects[loc_key].description then
                                    desc = ExtraEffects[loc_key].description
                                end
                                desc = table.clone(desc)
                                desc = Stacked.manual_parse(desc)
                            end
                        end
                        increase = increase + 1
                        type_shi = type_shi + 1
                        for i, box in ipairs(desc.text_parsed) do
                            for j, line in ipairs(box) do
                                local loc_vars = (v.key and ExtraEffects[v.key] and ExtraEffects[v.key].loc_vars and ExtraEffects[v.key].loc_vars({}, self, v.ability)) or {}
                                create_effect_box(v, i, desc, line, loc_vars)
                            end
                        end
                    end
                end
            end

            if not G.hsr_expand_tooltip then
                simplified_box(G.localization.ExtraEffects.joker_effect_expand, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})
            else
                simplified_box(G.localization.ExtraEffects.joker_effect_pages, {text_colour = G.C.UI.TEXT_LIGHT, vars = {current_page, max_pages}, shadow = true})
                if not G.hsr_hide_effects then
                    simplified_box(G.localization.ExtraEffects.joker_effect_hide, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})
                else
                    simplified_box(G.localization.ExtraEffects.joker_effect_show, {text_colour = G.C.UI.TEXT_LIGHT, shadow = true})
                end
            end
        end
    end
    return ret
end

local reloaded_stakes = {}
local skip_stake = {"stake_white", "stake_green", "stake_red"}
local hookTo = init_localization
function init_localization(...)
    local ret = hookTo(...)
    for i,v in pairs(G.localization.descriptions.Stake) do
        if not Stacked.t_contains(skip_stake,i) and not reloaded_stakes[i] then
            reloaded_stakes[i] = true
            local clone = table.clone(G.localization.descriptions.Stake[i])
            clone.name_parsed = nil
            clone.text_parsed = nil
            clone.text = clone.text or {}
            table.insert(clone.text, 1, Stacked.stylize_str("({C:red}Cursed{} extra effects are {C:attention}enabled{})", {stylize = {C = "inactive"}}))
            G.localization.descriptions.Stake[i] = Stacked.manual_parse(clone)
        end
    end

    return ret
end

local hookTo = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier)
    local ret = hookTo(trigger_obj, seed, base_numerator, base_denominator, identifier)

    for _,card in ipairs(G.jokers and G.jokers.cards or {}) do
        if card.ability.hsr_extra_effects then
            for i,v in ipairs(card.ability.hsr_extra_effects) do
                if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].probability_reroll then
                    local res = ExtraEffects[v.key].probability_reroll(card, trigger_obj, ret, v.ability, i, SMODS.post_prob[#SMODS.post_prob].numerator, SMODS.post_prob[#SMODS.post_prob].denominator)
                    if res then
                        if res.set_to_true then
                            ret = res.set_to_true
                        end
                        if res.set_to_false then
                            ret = not res.set_to_false
                        end
                        if res.to_true and not ret then
                            for i = 1, res.to_true do
                                if ret then break end
                                ret = pseudorandom(seed) < SMODS.post_prob[#SMODS.post_prob].numerator / SMODS.post_prob[#SMODS.post_prob].denominator
                                SMODS.post_prob[#SMODS.post_prob].result = ret
                                if res.func then
                                    res.func()
                                end
                            end
                        end
                        if res.to_false and ret then
                            for i = 1, res.to_false do
                                if not ret then break end
                                ret = pseudorandom(seed) < SMODS.post_prob[#SMODS.post_prob].numerator / SMODS.post_prob[#SMODS.post_prob].denominator
                                SMODS.post_prob[#SMODS.post_prob].result = ret
                                if res.func then
                                    res.func()
                                end
                            end
                        end
                        if res.until_true and not ret then
                            repeat
                                ret = pseudorandom(seed) < SMODS.post_prob[#SMODS.post_prob].numerator / SMODS.post_prob[#SMODS.post_prob].denominator
                                SMODS.post_prob[#SMODS.post_prob].result = ret
                                if res.func then
                                    res.func()
                                end
                            until ret
                        end
                        if res.until_false and ret then
                            repeat
                                ret = pseudorandom(seed) < SMODS.post_prob[#SMODS.post_prob].numerator / SMODS.post_prob[#SMODS.post_prob].denominator
                                SMODS.post_prob[#SMODS.post_prob].result = ret
                                if res.func then
                                    res.func()
                                end
                            until not ret
                        end
                    end
                end
            end
        end
    end

    return ret
end

local hookTo = Game.start_run
function Game.start_run(...)
    local ret = hookTo(...)

    if G.GAME.stake > 3 then
        G.GAME.cursed_effects_enable = G.GAME.cursed_effects_enable or true
    end

    return ret
end

local hookTo = Card.use_consumeable
function Card:use_consumeable(...)
    local ret = hookTo(self,...)
    if self.config and self.config.center and self.config.center.set == "Tarot" then
        for _,v in ipairs(G.jokers and G.jokers.cards or {}) do
            if v.ability and v.ability.hsr_extra_effects then
                for ii,vv in ipairs(v.ability.hsr_extra_effects) do
                    if vv.key == "joker_curse5" then
                        vv.ability.used_tarot = true
                    end
                end
            end
        end
    end
    return ret
end

local hookTo = Card.can_sell_card
function Card:can_sell_card(context)
    local ret = hookTo(self, context)
    if self.ability and self.ability.hsr_extra_effects then
        for _,v in ipairs(self.ability.hsr_extra_effects) do
            if v.key and ExtraEffects[v.key] and ExtraEffects[v.key].prevent_sold then
                return false
            end
        end
    end
    return ret
end
