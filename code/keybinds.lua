SMODS.Keybind{
    key_pressed = "x", 
    event = 'pressed',
    action = function(self)
        G.hsr_expand_tooltip = true
        if stck_hoveredCard and stck_hoveredCard.ability and stck_hoveredCard.ability.hsr_extra_effects then
            stck_hoveredCard.hsr_changing_page = true
            stck_hoveredCard:stop_hover()
            stck_hoveredCard:hover()
        end
    end
}

SMODS.Keybind{
    key_pressed = "x", 
    event = 'released',
    action = function(self)
        G.hsr_expand_tooltip = false
        if stck_hoveredCard and stck_hoveredCard.ability and stck_hoveredCard.ability.hsr_extra_effects then
            stck_hoveredCard.hsr_changing_page = true
            stck_hoveredCard:stop_hover()
            stck_hoveredCard:hover()
        end
    end
}

SMODS.Keybind{
    key_pressed = "x", 
    event = 'pressed',
    held_keys = {"lshift"},
    action = function(self)
        G.hsr_hide_effects = not not not G.hsr_hide_effects
        if stck_hoveredCard and stck_hoveredCard.ability and stck_hoveredCard.ability.hsr_extra_effects then
            stck_hoveredCard.hsr_changing_page = true
            stck_hoveredCard:stop_hover()
            stck_hoveredCard:hover()
        end
    end
}