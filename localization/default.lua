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
            c_stck_distort = {
                name = "Distort",
                text = {
                    "Give {C:attention}selected{} Joker a",
                    "{C:dark_edition}Timing{} effect",
                    "{C:inactive}(Must have room)",
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
    ExtraEffectTypes = {
        passive = "Passive",
        attack = "Attack",
        timing = "{C:stck_rainbow}Timing{}",
        potency = "Potency [{V:1}#1#{}%]",
        cursed = "{C:stck_cursed}Cursed",
    },
    ExtraEffects = {
        joker_youforgotyourfuckingdescription = {
            name = "you forgot {C:attention}loc_txt{}/{C:attention}localization{}",
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
            name = "Suit Synergy M",
            text = {
                "Scored {V:1}#2#{} cards",
                "give {C:mult}+#1#{} Mult",
            },
        },
        score_suit_chips = {
            name = "Suit Synergy C",
            text = {
                "Scored {V:1}#2#{} cards",
                "give {C:chips}+#1#{} Chips",
            },
        },
        score_suit_xmult = {
            name = "Suit Synergy X",
            text = {
                "Scored {V:1}#2#{} cards", 
                "give {X:mult,C:white}X#1#{} Mult",
            },
        },
        joker_buff1 = {
            name = "Amplify",
            text = {
                "Joker gives {X:stck_m_a_c,C:white}X#1#{} more",
                "{C:chips}Chips{}/{C:mult}Mult{}",
            },
        },
        joker_buff2 = {
            name = "Helping Hands",
            text = {
                "Joker gives {C:blue}+#1#{} #2#",
            },
        },
        joker_buff3 = {
            name = "More Discards",
            text = {
                "Joker gives {C:red}+#1#{} #2#",
            },
        },
        joker_buff4 = {
            name = "*But it refused.",
            text = {
                "Joker is {C:red}immune{} to {C:red}destruction{}",
                "#1# #3#",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        joker_buff5 = {
            name = "Faster Learner",
            text = {
                "Joker's {C:attention}scalings{} are {C:attention}multiplied",
                "by {X:attention,C:white}X#1#",
            },
        },
        joker_buff6 = {
            name = "Lenient Blinds",
            text = {
                "{C:attention}Blind size{} is decreased",
                "by {C:attention}#1#%{}",
            },
        },
        joker_buff7 = {
            name = "Fast Pacing",
            text = {
                "{C:attention}Retrigger{} this Joker {C:attention}once{}",
                "for {C:attention}#1#{} #2#",
            },
        },
        joker_buff8 = {
            name = "Recycling",
            text = {
                "When this Joker would get {C:red}destroyed{},",
                "{C:attention}reset{} its {C:attention}values{} instead",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        joker_buff9 = {
            name = "A Ritual's Sacrifice",
            text = {
                "When this Joker is {C:attention}destroyed{},",
                "create a {C:attention}#1#{} card",
                "{C:inactive}(Must have room)",
            },
        },
        joker_buff10 = {
            name = "Chips Absorption",
            text = {
                "{C:mult}+#1#{} Mult",
                "Convert {C:chips}#2#%{} Chips of {C:attention}scored{}",
                "cards to {C:mult}+Mult{}, decreases by {C:attention}half{}",
                "at end of round",
            },
        },
        joker_buff11 = {
            name = "Gradual Growth",
            text = {
                "Increase a {C:attention}random{} Effect's {C:attention}Potency{}",
                "of this Joker by {C:attention}#1#%{} {C:inactive}(except itself){}",
                "at end of round",
            },
        },
        joker_buff12 = {
            name = "A Friend's Sacrifice",
            text = {
                "When {C:red}destroyed{}, give a {C:attention}random{}",
                "owned Joker a {C:attention}random{} Effect",
                "{C:attention}#1#{} #2#",
            },
        },
        joker_buff13 = {
            name = "Better Odds",
            text = {
                "If Joker has {C:green}probabilities{},",
                "increase {C:green}numerator{} by {C:green}#1#{}",
            }
        },
        joker_buff14 = {
            name = "Blueprint...?",
            text = {
                "Copy ability of Joker to the {C:attention}#1#{},",
                "{X:stck_m_a_c,C:white}X#2#{} {C:mult}Mult{}/{C:chips}Chips{} given",
            },
        },
        joker_buff15 = {
            name = "Scaling Buddies",
            text = {
                "{X:stck_m_a_c,C:white}X#1#{} {C:mult}Mult{}/{C:chips}Chips{} given",
                "Increase by {X:stck_m_a_c,C:white}X0.02{} whenever",
                "a Joker's {C:attention}value{} is increased by",
                "{C:attention}#2#{} or below {C:inactive,s:0.75}(At least 0.2)",
                "{C:inactive,s:0.75}(Can gain up to {X:stck_m_a_c,C:white,s:0.75}X0.1{C:inactive,s:0.75} per round)",
            },
        },
        joker_buff16 = {
            name = "Protector",
            text = {
                "Prevent {C:attention}Playing Cards{} from",
                "being {C:red}destroyed{} #1# #3#",
                "{C:inactive}(Uses left: #2#){}",
            },
        },
        joker_buff17 = {
            name = "Converter",
            text = {
                "If Joker to the {C:attention}#1#{} gives {C:mult}+Mult{},",
                "gives {X:mult,C:white}XMult{} instead",
                "{C:inactive,s:0.75}({C:mult,s:0.75}+1{C:inactive,s:0.75} Mult = {X:mult,C:white,s:0.75}X#2#{C:inactive,s:0.75} Mult)",
            },
        },
        joker_buff18 = {
            name = "Duplication",
            text = {
                "Joker can appear {C:attention}multiple",
                "times",
            },
        },
        joker_buff19 = {
            name = "Again!",
            text = {
                "If Joker's {C:green}probability{} failed, {C:green}reroll{}",
                "it up to {C:attention}#1#{} #2#",
            },
        },
        joker_buff20 = {
            name = "More Mult",
            text = {
                "{C:mult}+#1#{} Mult",
            },
        },
        joker_buff21 = {
            name = "More Chips",
            text = {
                "{C:chips}+#1#{} Chips",
            },
        },
        joker_buff22 = {
            name = "More XMult",
            text = {
                "{C:white,X:mult}X#1#{} Mult",
            },
        },
        joker_buff23 = {
            name = "Better Finance",
            text = {
                "Increase {C:money}Interest Cap{}",
                "by {C:money}$#1#{}",
            },
        },
        joker_buff24 = {
            name = "Inflation",
            text = {
                "When a {C:attention}Joker{} is {C:attention}sold{},",
                "increase this Joker's {C:attention}Sell Value{}",
                "by {C:money}$#1#{}",
            },
        },
        joker_buff25 = {
            name = "Bank Income",
            text = {
                "Decrease money needed per {C:money}$1{}",
                "interest by {C:money}$#1#{}",
            },
        },
        joker_buff26 = {
            name = "Mult Conversion",
            text = {
                "Scored cards give {C:mult}+Mult{} equal",
                "to {C:chips}#1#%{} of their {C:chips}Chips{}",
            },
        },
        joker_buff27 = {
            name = "Attack Harmony MXM",
            text = {
                "When Joker to the {C:attention}#1#{} gives {C:mult}+Mult{}/{X:mult,C:white}XMult{},",
                "it counts as an {C:attention}Attack{}",
            },
        },
        joker_buff28 = {
            name = "Attack Harmony CXC",
            text = {
                "When Joker to the {C:attention}#1#{} gives {C:chips}+Chips{}/{X:chips,C:white}XChips{},",
                "it counts as an {C:attention}Attack{}",
            },
        },
        joker_buff29 = {
            name = "Commander",
            text = {
                "All {C:attention}Attacks{} give",
                "{X:stck_m_a_c,C:white}X#1#{} more {C:mult}Mult{}/{C:chips}Chips",
            },
        },
        joker_buff30 = {
            name = "Passing on the torch",
            text = {
                "When {C:red}destroyed{}, give a {C:attention}random{}",
                "owned Joker a {C:attention}random Attack{} Effect",
                "{C:attention}#1#{} #2#",
            },
        },
        joker_buff31 = {
            name = "Balanced Combat Stance MC",
            text = {
                "If an {C:attention}Attack{} gives {C:mult}+Mult{},",
                "give {C:chips}#1#%{} of that as {C:chips}+Chips{}",
            },
        },
        joker_buff32 = {
            name = "Balanced Combat Stance CM",
            text = {
                "If an {C:attention}Attack{} gives {C:mult}+Mult{},",
                "give {C:chips}#1#%{} of that as {C:chips}+Chips{}",
            },
        },
        joker_buff33 = {
            name = "Here comes the {C:blue}Tsunami{}!",
            text = {
                "Every {C:attention}played card{} counts in scoring",
            },
        },
        joker_buff34 = {
            name = "Unexpected Surge",
            text = {
                "Joker's {C:attention}end of round{} effects",
                "trigger on {C:attention}hand played{}",
            },
        },
        joker_buff35 = {
            name = "Unrestrained Acceleration",
            text = {
                "Joker's {C:attention}main{} effects",
                "trigger once {C:attention}per card in hand{}",
                "for {C:attention}#1#{} #3#",
                "{C:inactive}(Uses left: #2#)",
            },
        },
        joker_buff36 = {
            name = "Wider Reach",
            text = {
                "Joker's {C:attention}per scoring card{} effects",
                "trigger on cards {C:attention}held in hand{}",
            },
        },
        joker_buff37 = {
            name = "Stored Energy",
            text = {
                "If Joker is {C:attention}leftmost{}, give",
                "{X:stck_m_a_c,C:white}X#1#{} stored {C:mult}+Mult{}/{C:chips}+Chips{},",
                "and {C:attention}reset{} to {C:attention}0{}. Else, store {C:mult}+Mult{}/{C:chips}+Chips",
                "given by Joker",
                Stacked.stylize_str("(Currently stored: {C:mult}+#2#{} Mult, {C:chips}+#3#{} Chips)", {stylize = {s = 0.7, C = "inactive"}}),
            },
        },
        joker_buff38 = {
            name = "Follow-up Attack",
            text = {
                "If an {C:attention}Attack{} effect is {C:attention}triggered{},",
                "trigger this Joker's {C:attention}main{} effect",
                "{C:inactive}(Up to #1# times per hand)",
            },
        },
        joker_buff39 = {
            name = "Moonlight Dance",
            text = {
                "When Joker to the {C:attention}#1#{} triggers", --left/right
                "its {C:attention}main{} effect, trigger Joker",
                "to the {C:attention}#2#{}'s {C:attention}main{} effect", --right/left
                "{C:inactive}(Up to #3# times per hand)",
            },
        },
        joker_buff40 = {
            name = "Last Push",
            text = {
                "On {C:attention}last hand{}, retrigger",
                "{C:attention}main{} effect of {C:attention}#1#{} Jokers",
                Stacked.stylize_str("({C:attention}Leftmost{} to {C:attention}rightmost{})", {stylize = {s = 0.7, C = "inactive"}}),
            },
        },
        joker_buff41 = {
            name = "Stretched Hand",
            text = {
                "On {C:attention}hand played{}, add {C:attention}#1#{}",
                "{C:attention}leftmost{} #2# {C:attention}held{} in",
                "hand to {C:attention}scoring hand{} if possible",
                "{C:inactive,s:0.7}(?)",
                "{C:inactive,s:0.7}(Poker hand will not be changed)",
            },
        },
        joker_buff41_2 = {
            name = "Stretched Hand MAX",
            text = {
                "On {C:attention}hand played{}, add {C:attention}#1#{}",
                "{C:attention}leftmost{} #2# {C:attention}held{} in",
                "hand to {C:attention}scoring hand{} if possible",
                Stacked.stylize_str("Added cards will {C:attention}always{} score", {stylize = {s = 0.7, C = "inactive"}}),
                "{C:inactive,s:0.7}(Poker hand will not be changed)",
            },
        },

        uma_joker_buff1 = {
            name = "Triumphant Pulse",
            text = {
                "On {C:attention}last hand{},",
                "{C:attention}retrigger{} this Joker {C:attention}once{}",
            },
        },

        joker_curse1 = {
            name = "Instant Gratification",
            text = {
                "Increase money needed per {C:money}$1{}",
                "interest by {C:money}$#1#{}, give {C:money}$2{}",
                "at the end of round",
            },
        },
        joker_curse2 = {
            name = "Desire for Power",
            text = {
                "{C:red}Debuff{} Joker to the {C:attention}#1#{} when",
                "hand is {C:attention}played{}, and increase",
                "{C:mult}Mult{}/{C:chips}Chips{} given by {X:stck_m_a_c,C:white}X1.5{}",
            },
        },
        joker_curse3 = {
            name = "Preferential Treatment",
            text = {
                "If {C:attention}scored hand{} has {C:attention}2{}",
                "or more cards, {C:red}debuff{} {C:attention}#1#{} card,",
                "and {C:attention}retrigger{} {C:attention}#2#{} card once",
            },
        },
        joker_curse4 = {
            name = "Suit Preference",
            text = {
                "Scored {V:1}#1#{} cards give {C:mult}-#2#{} Mult",
                "Scored {V:2}#3#{} cards give {C:mult}+#4#{} Mult",
            },
        },
        joker_curse5 = {
            name = "Misleading Belief",
            text = {
                "Create a {C:attention}Tarot{} card at the",
                "end of round. Joker is {C:red}debuffed{} if",
                "no {C:attention}Tarot{} card is {C:attention}used{} in round",
                "{C:inactive}(Must have room)",
            },
        },
        joker_curse6 = {
            name = "Overachiever",
            text = {
                "Decrease {C:attention}blind requirement{} by",
                "{C:attention}20%{}, increase {C:attention}winning ante{} by",
                "{C:attention}1{}",
            },
        },
        joker_curse7 = {
            name = "Unreachable Potential",
            text = {
                "Joker {C:red}cannot{} be sold, increase",
                "{C:money}Sell Value{} by {C:money}$3{} at",
                "end of round",
            },
        },
        joker_curse8 = {
            name = "Wild Joker",
            text = {
                "When Joker is {C:red}destroyed{}, become a",
                "random Joker of the same {C:attention}rarity{}",
                "instead for {C:attention}#1#{} #3#",
                "{C:inactive}(Uses left: #2#)",
            },
        },
    },
    misc = {
        dictionary = {
            joker_buff14_direction_left = "left",
            joker_buff14_direction_right = "right",
            stck_plural_hands = "Hands",
            stck_singular_hands = "Hand",
            stck_plural_discards = "Discards",
            stck_singular_discards = "Discard",
            stck_plural_times = "Times",
            stck_singular_times = "Time",
            stck_plural_rounds = "Rounds",
            stck_singular_rounds = "Round",
            stck_plural_cards = "Cards",
            stck_singular_cards = "Card",
            stck_most_left = "leftmost",
            stck_most_right = "rightmost",
        },
    }
}