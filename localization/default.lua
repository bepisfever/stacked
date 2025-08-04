return{
    descriptions = {
        Spectral = {
            c_stck_anvil = {
                name = 'Anvil',
                text = {
                    "Increase a {C:attention}random{} Effect's {C:attention}Potency{}",
                    "on a {C:attention}random{} Joker by {C:attention}#1#%{}",
                    "{C:inactive}(Up to #2#%){}",
                    "{C:inactive,s:0.65}(Art and Idea credit: factwixard)",
                },
            },
        },
        Voucher = {
            v_stck_e_slot_upgrade1 = {
                name = "Multitalented",
                text = {
                    "Increases {C:attention}Maximum Effect Slots{} of",
                    "Jokers by {C:attention}1{}",
                    "{C:inactive,s:0.65}(Art Credit: Flote)",
                },
            },
            v_stck_e_slot_upgrade2 = {
                name = "Prodigy",
                text = {
                    "Increases {C:attention}Maximum Effect Slots{} of",
                    "Jokers by {C:attention}1{}",
                    "{C:inactive,s:0.65}(Art Credit: Flote)",
                },
            },
            v_stck_e_rate_upgrade1 = {
                name = "Clown Education",
                text = {
                    "Increases {C:attention}Effect Spawn Rate{} of",
                    "Jokers by {C:attention}10%{}",
                    "{C:inactive,s:0.65}(Art Credit: Flote)",
                },
            },
            v_stck_e_rate_upgrade2 = {
                name = "Comedy Degree",
                text = {
                    "Increases {C:attention}Effect Spawn Rate{} of",
                    "Jokers by {C:attention}10%{}",
                    "{C:inactive,s:0.65}(Art Credit: Flote)",
                },
            },
            v_stck_e_potency_upgrade1 = {
                name = "Big Stacks",
                text = {
                    "Increases {C:attention}Effect Potency Cap{} of",
                    "Jokers by {C:attention}25%{}",
                    "{C:inactive,s:0.65}(Art Credit: Flote)",
                },
            },
            v_stck_e_potency_upgrade2 = {
                name = "Heavy Stacker",
                text = {
                    "Increases {C:attention}Effect Potency Cap{} of",
                    "Jokers by {C:attention}25%{}",
                    "{C:inactive,s:0.65}(Art Credit: Flote)",
                },
            },
        },
    },
    ExtraEffects = {
        joker_youforgotyourfuckingdescription = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{C:green}69%{}{C:inactive}){}",
                "wheres your description bro"
            },
        },
        joker_effect_expand = {
            text = {
                "{s:0.7,C:white}Hold [X] to see more info",
            },
        },
        joker_effect_show = {
            text = {
                "{s:0.7,C:white}Press [LShift + X] to show effects",
            },
        },
        joker_effect_hide = {
            text = {
                "{s:0.7,C:white}Press [LShift + X] to hide effects",
            },
        },
        joker_effect_pages = {
            text = {
                "[Page #1#/#2#]",
                "{s:0.7}Use {C:attention,s:0.7}scroll-wheel{s:0.7} to turn",
                "{s:0.7}Effect pages",
            },
        },
        joker_effect_separator = {
            text = {
                "{s:1.3,C:white,E:1}Extra Effects [Stacked]",
            },
        },
        score_suit_mult = {
            text = {
                "{C:inactive}[Attack]{} {C:inactive}({}{V:2}#3#%{}{C:inactive}){}",
                "Scored {V:1}#2#{} cards",
                "give {C:mult}+#1#{} Mult",
            },
        },
        score_suit_chips = {
            text = {
                "{C:inactive}[Attack]{} {C:inactive}({}{V:2}#3#%{}{C:inactive}){}",
                "Scored {V:1}#2#{} cards",
                "give {C:chips}+#1#{} Chips",
            },
        },
        score_suit_xmult = {
            text = {
                "{C:inactive}[Attack]{} {C:inactive}({}{V:2}#3#%{}{C:inactive}){}",
                "Scored {V:1}#2#{} cards",
                "give {X:mult,C:white}X#1#{} Mult",
            },
        },
        joker_buff1 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker gives {X:dark_edition,C:white}X#1#{} more",
                "{C:chips}Chips{}/{C:mult}Mult{}",
            },
        },
        joker_buff2 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker gives {C:blue}+#1#{} Hands",
            },
        },
        joker_buff3 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker gives {C:red}+#1#{} Discards",
            },
        },
        joker_buff4 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "Joker is {C:red}immune{} to {C:red}destruction{}",
                "#1# times",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        joker_buff5 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Joker's {C:attention}scalings{} are {C:attention}multiplied",
                "by {X:attention,C:white}X#1#",
            },
        },
        joker_buff6 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "{C:attention}Blind size{} is decreased",
                "by {C:attention}#1#%{}",
            },
        },
        joker_buff7 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "{C:attention}Retrigger{} this Joker {C:attention}once{}",
                "for {C:attention}#1#{} rounds",
            },
        },
        joker_buff8 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "When this Joker would get {C:red}destroyed{},",
                "{C:attention}reset{} its {C:attention}values{} instead",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        joker_buff9 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "When this Joker is {C:attention}destroyed{},",
                "create a {C:attention}#1#{} card",
                "{C:inactive}(Must have room)",
            },
        },
        joker_buff10 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "{C:mult}+#1#{} Mult",
                "Convert {C:chips}#2#%{} Chips of {C:attention}scored{}",
                "cards to {C:mult}+Mult{}, decreases by {C:attention}half{}",
                "at end of round",
            },
        },
        joker_buff11 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "Increase a {C:attention}random{} Effect's {C:attention}Potency{}",
                "of this Joker by {C:attention}#1#%{} {C:inactive}(except itself){}",
                "at end of round",
            },
        },
        joker_buff12 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "When {C:red}destroyed{}, give a {C:attention}random{}",
                "owned Joker a {C:attention}random{} Effect",
                "{C:attention}#1#{} times",
            },
        },
        joker_buff13 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#2#%{}{C:inactive}){}",
                "If Joker has {C:green}probabilities{},",
                "increase {C:green}numerator{} by {C:green}#1#{}",
            }
        },
        joker_buff14 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "Copy ability of Joker to the {C:attention}#1#{},",
                "{X:dark_edition,C:white}X#2#{} {C:mult}Mult{}/{C:chips}Chips{} given",
            },
        },
        joker_buff15 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "{X:dark_edition,C:white}X#1#{} {C:mult}Mult{}/{C:chips}Chips{} given",
                "Increase by {X:dark_edition,C:white}X0.02{} whenever",
                "a Joker's {C:attention}value{} is increased by",
                "{C:attention}#2#{} or below {C:inactive,s:0.75}(At least 0.2)",
                "{C:inactive,s:0.75}(Can gain up to {X:dark_edition,C:white,s:0.75}X0.1{C:inactive,s:0.75} per round)",
            },
        },
        joker_buff16 = {
            text = {
                "{C:inactive}[Passive]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "Prevent {C:attention}Playing Cards{} from",
                "being {C:red}destroyed{} #1# times",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        joker_buff17 = {
            text = {
                "{C:inactive}[Link]{} {C:inactive}({}{V:1}#3#%{}{C:inactive}){}",
                "If Joker to the {C:attention}#1#{} gives {C:mult}+Mult{},",
                "gives {X:mult,C:white}XMult{} instead",
                "{C:inactive,s:0.75}({C:mult,s:0.75}+1{C:inactive,s:0.75} Mult = {X:mult,C:white,s:0.75}X#2#{C:inactive,s:0.75} Mult)",
            },
        },
        joker_buff18 = {
            text = {
                "{C:inactive}[Passive]{}",
                "Joker can appear {C:attention}multiple",
                "times",
            },
        },
    },
    misc = {
        dictionary = {
            joker_buff14_direction_left = "left",
            joker_buff14_direction_right = "right",
        },
    }
}