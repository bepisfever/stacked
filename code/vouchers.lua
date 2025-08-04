SMODS.Atlas ({
    key = 'upgrade_vouchers',
    path = 'upgrade_vouchers.png',
    px = 71,
    py = 95,
})

SMODS.Voucher{
    key = "e_slot_upgrade1",
    atlas = "upgrade_vouchers",
    pos = {x = 0, y = 0},
    cost = 10,
    redeem = function(self, card)
        G.GAME.hsr_maximum_extra_effects = G.GAME.hsr_maximum_extra_effects + 1
    end,
}

SMODS.Voucher{
    key = "e_slot_upgrade2",
    requires = {"e_slot_upgrade1"},
    atlas = "upgrade_vouchers",
    pos = {x = 1, y = 0},
    cost = 10,
    redeem = function(self, card)
        G.GAME.hsr_maximum_extra_effects = G.GAME.hsr_maximum_extra_effects + 1
    end,
}

SMODS.Voucher{
    key = "e_rate_upgrade1",
    atlas = "upgrade_vouchers",
    pos = {x = 0, y = 1},
    cost = 10,
    redeem = function(self, card)
        G.GAME.hsr_extra_chance_rate = G.GAME.hsr_extra_chance_rate * 0.9
    end,
}

SMODS.Voucher{
    key = "e_rate_upgrade2",
    requires = {"e_rate_upgrade1"},
    atlas = "upgrade_vouchers",
    pos = {x = 1, y = 1},
    cost = 10,
    redeem = function(self, card)
        G.GAME.hsr_extra_chance_rate = G.GAME.hsr_extra_chance_rate * 0.9
    end,
}

SMODS.Voucher{
    key = "e_potency_upgrade1",
    atlas = "upgrade_vouchers",
    pos = {x = 0, y = 2},
    cost = 10,
    redeem = function(self, card)
        G.GAME.hsr_potency_cap = G.GAME.hsr_potency_cap + 25
    end,
}

SMODS.Voucher{
    key = "e_potency_upgrade2",
    requires = {"e_potency_upgrade1"},
    atlas = "upgrade_vouchers",
    pos = {x = 1, y = 2},
    cost = 10,
    redeem = function(self, card)
        G.GAME.hsr_potency_cap = G.GAME.hsr_potency_cap + 25
    end,
}