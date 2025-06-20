SMODS.Atlas(
    {
        key = "RalseiSheet",
        path = "oopsallralsei.png",
        px = 71,
        py = 95
    }
)

SMODS.Atlas{
    key = "modicon",
    path = "icon.png", -- the file in BOTH assets/1x and assets/2x
    px = 32,
    py = 32
}

SMODS.load_file('animateObject.lua')()

G.C.color2 = HEX('1f5f4b')
G.C.color1 = HEX('4dcc8e')
local oldmenu = Game.main_menu
function Game:main_menu(change_context)
  local ret = oldmenu(self,change_context)  
  G.SPLASH_BACK:define_draw_steps({
        {
            shader = "splash",
            send = {
                { name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", val = 0.4 },
                { name = "colour_1", ref_table = G.C, ref_value = "color1" },
                { name = "colour_2", ref_table = G.C, ref_value = "color2" },
            },
        },
    })
    return ret
end

    function Card:resize(mod, force_save)
        self:hard_set_T(self.T.x, self.T.y, self.T.w * mod, self.T.h * mod)
        remove_all(self.children)
        self.children = {}
        self.children.shadow = Moveable(0, 0, 0, 0)
        self:set_sprites(self.config.center, self.base.id and self.config.card)
    end

    local mainmenuref2 = Game.main_menu
    Game.main_menu = function(change_context)

        local ret = mainmenuref2(change_context)
        local newcard = SMODS.create_card({key='j_OAL_Plushie',area = G.title_top})
        G.title_top.T.w = G.title_top.T.w * 1.7675
        G.title_top.T.x = G.title_top.T.x - 0.8
        G.title_top:emplace(newcard)
        newcard:start_materialize()
        newcard:resize(1.1 * 1.2)
        newcard.no_ui = true
        return ret
    end

SMODS.Joker {
    key = "HoodiedRalsei",
    loc_txt = {
        name = "Hooded Ralsei",
        text = {
            "This Ralsei gains {C:mult}+2{} Mult per {C:spades}Spade{} suit played",
            "{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}mult){}"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    discovered = true,
    pos = {x = 0, y = 0}, -- This will be animated
    rarity = 1,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Spades') then
            card.ability.extra.multgiven = card.ability.extra.multgiven + 2
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.multgiven
            }
        end
    end,
}

SMODS.Joker {
    key = "HattedRalsei",
    loc_txt = {
        name = "Ralsei",
        text = {
            "This Ralsei gains {C:mult}+1{} Mult per {C:hearts}Heart{} or {C:spades}Spade{} suit played",
            "{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}mult){}"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 0, y = 1}, -- This will be animated
    rarity = 1,
    discovered = true,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Hearts') or context.other_card:is_suit('Spades') then
            card.ability.extra.multgiven = card.ability.extra.multgiven + 1
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.multgiven
            }
        end
    end,
    AddRunningAnimation({"j_OAL_HattedRalsei",0.1,4,0,"loop",0,1,card})
}

SMODS.Joker {
    key = "HatlessRalsei",
    loc_txt = {
        name = "Hatless Ralsei",
        text = {
            "This Ralsei gains {C:mult}+2{} Mult per {C:hearts}Heart{} suit played",
            "{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}mult){}"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 0, y = 2}, -- This will be animated
    rarity = 1,
    discovered = true,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Hearts') then
            card.ability.extra.multgiven = card.ability.extra.multgiven + 2
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.multgiven
            }
        end
    end,
    AddRunningAnimation({"j_OAL_HatlessRalsei",0.1,4,0,"loop",0,2,card})
}

SMODS.Joker {
    key = "ButlerRalsei",
    loc_txt = {
        name = "Butler Ralsei",
        text = {
            "This Ralsei lets you go in an {C:attention}extra{} {C:red}-$20{} in debt"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 0, y = 3}, -- This will be animated
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card, from_debuff)
        if from_debuff == false then
            G.GAME.bankrupt_at = G.GAME.bankrupt_at + 20
        end

    end,
    remove_from_deck = function(self, card, from_debuff)
        if from_debuff == false then
            G.GAME.bankrupt_at = G.GAME.bankrupt_at - 20
        end
    end
}

SMODS.Joker {
    key = "CartRalsei",
    loc_txt = {
        name = "Ralsei in a cart",
        text = {
            "If played hand contains {C:attention}5 scored cards{}, rank up by their position",
            "{C:inactive}(First card ranks up by one, Second by two and so on)"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 1, y = 3}, -- This will be animated
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    discovered = true,
    perishable_compat = true,
calculate = function(self, card, context)
    if context.final_scoring_step and #context.scoring_hand >= 5 then
        for _, v in ipairs(context.scoring_hand) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    v:flip()
                    SMODS.modify_rank(v, _)
                    play_sound('tarot1', 0.96 + math.random() * 0.08)
                    SMODS.calculate_effect({message = "Bumped!", instant = true}, v)
                    v:flip()
                    return true
                end
            }))
        end
    end
end
}

SMODS.Joker {
    key = "YarnRalsei",
    loc_txt = {
        name = "Yarn Ralsei",
        text = {
            "Cards {C:attention}held in hand{} at end of round move {C:attention}up a rank"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 2, y = 3}, -- This will be animated
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
    if context.end_of_round then
        for _,v in ipairs(G.hand.cards) do
                SMODS.modify_rank(v, 1)
            end
        end
    end,
}

SMODS.Joker {
    key = "Nurse Ralsei",
    loc_txt = {
        name = "Nurse Ralsei",
        text = {
            "Heals {{C:attention}scored{} damaged cards"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 3, y = 3}, -- This will be animated
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    calculate = function(self, card, context)
                if context.before then
            for _,v in ipairs(context.scoring_hand) do
                v:set_ability("m_OAL_Healed")
                SMODS.calculate_effect({message = "Healed"}, v)
            end
        end
    end,
}

SMODS.Joker {
    key = "Dummy",
    loc_txt = {
        name = "Training Dummy",
        text = {
            "Antes scale {C:attention}half as fast{}",
            "{C:attention}Vouchers{} do not appear in the shop"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 4, y = 3}, -- This will be animated
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if from_debuff == false then
        SMODS.change_voucher_limit(-1)
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / 2
        end

    end,
    remove_from_deck = function(self, card, from_debuff)
        if from_debuff == false then
        SMODS.change_voucher_limit(1)
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 2
        end
    end
}

SMODS.Joker {
    key = "GameRalsei",
    loc_txt = {
        name = "Game Ralsei",
        text = {
            "Retriggers 8 of {C:hearts}Hearts{} 3 times"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 5, y = 3}, -- This will be animated
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_suit('Hearts') and context.other_card:get_id() == 8 then
                return {
                    repetitions = 3
                }
            end
        end
    end,
}

SMODS.Joker {
    key = "CookerRalsei",
    loc_txt = {
        name = "Chef Ralsei",
        text = {
            "Scored Cards {C:attention}without{} a seal gain the {C:attention}cake seal{}",
            "When a cake seal is {C:attention}scored{} with this Ralsei, {C:chips}+50{} chips"
        }
    },
    config = {
        extra = {chipsgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.chipsgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 6, y = 3}, -- This will be animated
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    discovered = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before then
            for _,v in ipairs(context.scoring_hand) do
                if not v.seal then
                    v:set_seal("OAL_CakeSeal", true, true)
                end
            end
        end
    if context.cardarea == G.play  then
        for _,v in ipairs(context.scoring_hand) do
            if  v.seal == "OAL_CakeSeal" then
                return{chips=50}
            end
        end
    end
end,
}

SMODS.Joker {
    key = "HorseRalsei",
    loc_txt = {
        name = "Horse Ralsei",
        text = {
            "Every played {C:attention}card{} gains a permanent {C:chips}+5{} chips and {C:mult}+1{} mult",
        }
    },
    config = {
        extra = {chips = 5, mult = 1}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.chips, card.ability.extra.mult}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 7, y = 3}, -- This will be animated
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                extra = { message = "Neigh", colour = G.C.CHIPS },
                card = card
            }
        end
    end,
}

SMODS.Joker {
    key = "RockstarRalsei",
    loc_txt = {
        name = "Rockstar Ralsei",
        text = {
            "This Ralsei turns cards into {C:attention}damaged cards{},",
            "Scored {C:attention}damaged cards{} add {X:mult,C:white}X0.1{} mult to this Ralsei",
            "{C:inactive} (Currently{} {X:mult,C:white}X#1#{}{C:inactive}){}"
        }
    },
    config = {
        extra = {Xmult = 1}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 0, y = 4}, -- This will be animated
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.before then
            for _,v in ipairs(context.scoring_hand) do
                v:set_ability("m_OAL_Damaged")
                SMODS.calculate_effect({message = "DAMAGED!"}, v)
                card.ability.extra.Xmult = card.ability.extra.Xmult + 0.1
                SMODS.calculate_effect({message = "Upgraded!"}, card)
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
    AddRunningAnimation({"j_OAL_RockstarRalsei",0.1,1,0,"loop",0,4,card})
}

SMODS.Joker {
    key = "MobsterRalsei",
    loc_txt = {
        name = "Mobster Ralsei",
        text = {
            "For every {C:hearts}Heart{} suit card destroyed,",
            "this Ralsei gains {X:mult,C:white}X0.2{} Mult",
            "{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}",
        }
    },
    config = {
        extra = {Xmult = 1}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 0, y = 5}, -- This will be animated
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for _,v in ipairs(context.removed) do
                if v:is_suit("Hearts") then
                    SMODS.calculate_effect({message = "Upgraded!"}, card)
                    card.ability.extra.Xmult = (card.ability.extra.Xmult or 1) + 0.2
                end
            end
        end
        if context.joker_main then
		return {
			Xmult = card.ability.extra.Xmult
		}
	end
    end,
    AddRunningAnimation({"j_OAL_MobsterRalsei",0.1,7,0,"loop",0,5,card}),
}

SMODS.Joker {
    key = "Squish",
    loc_txt = {
        name = "Splat",
        text = {
            "{C:mult}+4{} Mult for every {C:hearts}Heart{} card missing from your full deck",
            "{C:inactive}(Currently{} {C:mult}+#1#{}{C:inactive} Mult){}"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 7, y = 4}, -- This will be animated
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.multgiven > 0 then
                return {
                    mult = card.ability.extra.multgiven
                }
            end
        end
    end,
    update = function(self, card, dt)
    if G.STAGE == G.STAGES.RUN then
    local heartsindeck = 0
        for k, v in pairs(G.playing_cards) do
            if v:is_suit("Hearts") then
                heartsindeck = heartsindeck + 1
                card.ability.extra.multgiven = (13 - heartsindeck) * 4
                end
            end
        end
    end
}

SMODS.Joker {
    key = "Plushie",
    loc_txt = {
        name = "Ralsei Plushie",
        text = {
            "{C:mult}+32{} Mult, {X:mult,C:white}X3.2{}} Mult"
        }
    },
    config = {
        extra = {multgiven = 0}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.multgiven}
        }
    end,
    atlas = "RalseiSheet",
    pos = {x = 6, y = 2}, -- This will be animated
    soul_pos = {x = 5, y = 2},
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = 32,
                xmult = 3.2
            }
        end
    end,
}

SMODS.Enhancement {
    key = "Damaged",
    loc_txt = {
        name = "Damaged Card",
        text = {
            "When this card is {C:attention}played{} 5 {C:inactive}(#1#){} times, destroys itself"
        }
    },
        config = {
        extra = {PlaysLeft = 5}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.PlaysLeft}
        }
    end,
    atlas = 'RalseiSheet',
    discovered = true,
    pos = {x = 2, y = 4},
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            card.ability.extra.PlaysLeft = card.ability.extra.PlaysLeft - 1
        end 
        if context.destroy_card and context.destroy_card == card then
            if card.ability.extra.PlaysLeft == 0 then
                return { remove = true }
            end
        end
    end,
}

SMODS.Enhancement {
    key = "Healed",
    loc_txt = {
        name = "Healing Card",
        text = {
            "When this card is {C:attention}played{} 3 {C:inactive}(#1#){} times,",
            "remove enhancement and make a copy"
        }
    },
        config = {
        extra = {PlaysLeft = 3}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.PlaysLeft}
        }
    end,
    atlas = 'RalseiSheet',
    discovered = true,
    pos = {x = 3, y = 4},
        calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            card.ability.extra.PlaysLeft = card.ability.extra.PlaysLeft - 1
            if card.ability.extra.PlaysLeft == 0 then
                card:set_ability("c_base")
                local _card = copy_card(card, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
            end
        end

    end
}

SMODS.Seal {
    key = "CakeSeal",
    discovered = true,
    loc_txt = {
        name = "Cake",
        text = {
            "Does nothing on its own"
        },
        label = "Cake"
    },
    badge_colour = HEX('4dcc8e'),
    atlas = 'RalseiSheet',
    pos = {x = 4, y = 4}
}

SMODS.Shader {
    key = "lover",
    path = "lover.fs"
}

SMODS.Edition {
    key = "Loving",
    discovered = true,
    loc_txt = {
        name = "Love",
        text = {
            "{C:chips}+50{} chips, {C:mult}+10{} Mult, {X:mult,C:white}X1.5{} Mult"
        },
        label = "Love"
    },
    shader = "OAL_lover",
    config = {
        chips = 50,
        mult = 10,
        x_mult = 1.5
    }
}