SMODS.Atlas{
    key = "MintConditionConsumeables",
    path = "consumeables.png",
    px = 71,
    py = 95
}

SMODS.ConsumableType {
    key = 'calculator',
    loc_txt = {
        name = 'Calculator',
        collection = 'Calculator Keys',
        undiscovered = {
            name = 'Undiscovered Key',
            text = {'Found in Calculator Packs'}
        }
    },    
    primary_colour = HEX("FFFFFF"),
    secondary_colour = HEX("A1A5A9"),
    default = 'c_mintconditioncards_balloon',
    collection_rows = {5, 5, 6},
    shop_rate = 0
}

--Undiscovered--
SMODS.UndiscoveredSprite {
    key = 'calculator',
    atlas = "MintConditionConsumeables",
    pos = {x = 4, y = 3}
}

--Balloon--
SMODS.Consumable{
    key = 'balloon',
    set = "calculator",
    config = {extra = {money = 4, numerator = 1, denominator = 3}},
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'balloon_destroy')
		return { vars = {card.ability.extra.money, new_numerator, new_denominator} }
    end,
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=0,y=1},
    cost = 3,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, 'balloon_destroy', card.ability.extra.numerator, card.ability.extra.denominator) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_flyaway')
                }
            else
                return {
                    dollars = card.ability.extra.money,
                    func = function() -- This is for timing purposes, it runs after the dollar manipulation
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end,
}
--Flag--
SMODS.Consumable{
    key = 'flag',
    set = "calculator",
    config = {extra = {createplanetcard = 1}},
    pixel_size = {h = 62},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.createplanetcard}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=1,y=1},
    cost = 3,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        for i = 1, card.ability.extra.createplanetcard do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Planet', edition = 'e_negative' })
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.6)
    end
}

--Hook--
SMODS.Consumable{
    key = 'hook',
    set = "calculator",
    config = {extra = {discardadd = 1}},
    pixel_size = {h = 62},
    loc_vars = function(self, infoqueue, card)
        return { vars = {card.ability.extra.discardadd}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=2,y=1},
    cost = 3,
    can_use = function (self, card)
        if G.GAME.blind.in_blind then
            return true
        end
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(card.ability.extra.discardadd)
                    return true
                end
            }))
    end
}

--Ladder--
SMODS.Consumable{
    key = 'ladder',
    set = "calculator",
    config = {extra = {reduceblind = 0.95}},
    loc_vars = function(self, infoqueue, card)
        return { vars = {card.ability.extra.reduceblind}}
    end,
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=0,y=2},
    cost = 3,
}

--Tree--
SMODS.Consumable{
    key = 'tree',
    set = "calculator",
    config = {},
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=1,y=2},
    cost = 3,
}

--Snake--
SMODS.Consumable{
    key = 'snake',
    set = "calculator",
    config = {extra = {draw = 3}},
    pixel_size = {h = 62},
    loc_vars = function(self, infoqueue, card)
        return { vars = {card.ability.extra.draw}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=2,y=2},
    cost = 3,
    can_use = function (self, card)
        if G.hand and #G.deck.cards > 0 and #G.hand.cards >=1 then
            return true
        end
    end,
    use = function (self, card, area, copier)
        SMODS.draw_cards(card.ability.extra.draw)
    end
}

--Hatchet--
SMODS.Consumable{
    key = 'hatchet',
    set = "calculator",
    config = {extra = {undebuff = 3}},
    loc_vars = function (self, info_queue, card)
        return{vars = {card.ability.extra.undebuff}}
    end,
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=1,y=0},
    cost = 3,
    can_use = function (self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.undebuff then
            for i= 1, #G.hand.highlighted do
                if G.hand.highlighted[i].debuff == true then
                    return true
                end
            end
        end
    end,
    use = function (self, card, area, copier)
        for i, playing_card in ipairs(G.hand.highlighted) do
            if G.hand.highlighted[i].debuff == true then
                playing_card:set_debuff(false)
                playing_card.hatchet_undebuff = true
            end
        end
    end
}
SMODS.current_mod.set_debuff = function (card)
    if card.hatchet_undebuff == true then
        return "prevent_debuff"
    end
end
-- See currentmodcalc.lua lines 9-14


--Hoe--
SMODS.Consumable{
    key = 'hoe',
    set = "calculator",
    loc_txt = {
        name = 'Hoe',
        text = {''}
    },
    config = {},
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=2,y=0},
    cost = 3,
}

--Binoculars--
SMODS.Consumable{
    key = 'binoculars',
    set = "calculator",
    config = { extra = {tiles = 2 }},
    loc_vars = function(self, info_queue, card)
        return{vars = {card.ability.extra.tiles, colours = {HEX("A1A5A9")}}}
    end,
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=3,y=0},
    cost = 3,
    use = function (self, card, area, copier)
        for i = 1, math.min(card.ability.extra.tiles, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'calculator' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function (self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + 1
    end
}

--Axe--
SMODS.Consumable{
    key = 'axe',
    set = "calculator",
    config = {extra = {selection = 3, money = 3,}},
    loc_vars = function (self, info_queue, card)
        return{vars = {card.ability.extra.selection, card.ability.extra.money}}
    end,
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=4,y=0},
    cost = 3,
    can_use = function (self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.selection then
            for i = 1, #G.hand.highlighted do
                if next(SMODS.get_enhancements(G.hand.highlighted[i])) then
                    return true
                end
            end
        end
    end,
    use = function (self, card, area, copier)
        local rewardmult = 0
        for i, playing_card in ipairs(G.hand.highlighted) do
            if next(SMODS.get_enhancements(G.hand.highlighted[i])) then
                rewardmult = rewardmult + 1
                playing_card:set_ability('c_base', nil, true)
                G.E_MANAGER:add_event(Event({delay = 0.15,
                        func = function()
                            playing_card:juice_up()
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            return true
                        end
                    }))
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func= function() ease_dollars(card.ability.extra.money * rewardmult) return true end}))
    end
}


--Dynamite--
SMODS.Consumable{
    key = 'dynamite',
    set = "calculator",
    config = {extra = {blindmult = 0.5, minushandsize = 1}},
    pixel_size = {h = 62},
    loc_vars = function (self, info_queue, card)
        return{vars = {card.ability.extra.blindmult, card.ability.extra.minushandsize}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=3,y=1},
    cost = 3,
    calculate = function (self, card, context)
        if context.setting_blind and context.blind.boss then
            G.hand:change_size(-card.ability.extra.minushandsize)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindmult
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            play_sound('timpani')
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.destroy_cards(card, nil, nil, true)
                    SMODS.calculate_effect({ message = localize('ph_kaboom') }, card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end
}

--Cross--
SMODS.Consumable{
    key = 'cross',
    set = "calculator",
    config = {extra = {handadd = 1}},
    pixel_size = {h = 62},
    loc_vars = function(self, infoqueue, card)
        return { vars = {card.ability.extra.handadd}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=4,y=1},
    cost = 3,
    can_use = function (self, card)
        if G.GAME.blind.in_blind then
            return true
        end
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
                func = function()
                    ease_hands_played(card.ability.extra.handadd)
                    return true
                end
            }))
    end
}

--Arrow--
SMODS.Consumable{
    key = 'arrow',
    set = "calculator",
    config = { extra = {blindmult = 0.9}},
    pixel_size = {h = 62},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.blindmult}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=3,y=2},
    cost = 3,
    can_use = function (self, card)
        if G.GAME.blind.in_blind then
            return true
        end
    end,
    use = function (self, card, area, copier)
        --i really don't know how to make the media player cover the entire window or crash the game manually
        --[[local richard_crash = false
        for i, consumeable in ipairs(G.consumeables.cards) do
            if consumeable.config.center.key == 'c_mintconditioncards_balloon' then
                richard_crash = true
            end
        end
        if richard_crash then -- easter egg --
              G.FUNCS.overlay_menu{definition = create_fullscreen_video("calc_crash",5), config = {no_esc = true}}
        else -- regular functionality --
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindmult
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end -]]
        G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindmult
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
}

--Treasure--
SMODS.Consumable{
    key = 'treasure',
    set = "calculator",
    config = {extra = {adddollars = 20, card_id = nil}},
    pixel_size = {h = 62},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.adddollars}}
    end,
    atlas = "MintConditionConsumeables",
    pos = {x=4,y=2},
    cost = 3,
    --[[ legacy functionality
    can_use = function (self, card)
        if G.hand then
            return true
        end
    end,
    use = function (self, card, area, copier)
        local temp_deck = {}

        for i, playing_card in ipairs(G.playing_cards) do temp_deck[#temp_deck+1] = playing_card end
        table.sort(temp_deck,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )
        pseudoshuffle(temp_deck, 'treasure')
        for i = 1, card.ability.extra.addseals do temp_deck[i]:set_seal('Gold', nil, true) end
    end, ]]--
    add_to_deck = function (self, card, from_debuff)
        local random = pseudorandom_element("mintconditioncards_bury_treasure", 1, #G.playing_cards)
        card.ability.extra.card_id = G.playing_cards[random].sort_id
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.sort_id == card.ability.extra.card_id then
            return 
                {dollars = card.ability.extra.adddollars,
                    func = function ()
                        SMODS.destroy_cards(card, nil, nil, true)
                        SMODS.calculate_effect({ message = localize('ph_treasure') }, card)
                    end
                }
        end
    end
}

--Paddles--
SMODS.Consumable{
    key = 'paddles',
    set = "calculator",
    config = {},
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=0,y=3},
    cost = 3,
    can_use = function (self, card)
        if G.GAME.blind.in_blind then
            return true
        end
    end,
    use = function (self, card, area, copier)
        if G.GAME.selected_back.name ~= 'Plasma Deck' then -- Plasma Deck already balances chips and mult
            G.E_MANAGER:add_event(Event({
            func = (function()
                local text = localize('k_balanced')
                play_sound('gong', 0.94, 0.3)
                play_sound('gong', 0.94*1.5, 0.2)
                play_sound('tarot1', 1.5)
                ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                attention_text({
                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                return true
            end)
        }))
            Paddlebalancecheck = true
        else                            -- do Wheel of Fortune "Nope!" when used with Plasma Deck
            G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
    end
}
-- see currentmodcalc.lua lines 16-23 for reset functionality

--Headstone--
SMODS.Consumable{
    key = 'headstone',
    set = "calculator",
    config = {},
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=2,y=3},
    cost = 3,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval and not G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = localize('k_saved_ex'),
                    saved = 'ph_headstone',
                    colour = G.C.RED
                }
            end
    end,
}