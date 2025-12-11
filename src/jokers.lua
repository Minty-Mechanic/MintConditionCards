SMODS.Atlas{
    key = "MintConditionCards",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "millicent",
    config = { extra = {xmult = 1.5} },
    blueprint_compat = true,
    rarity = 1,
    atlas = "MintConditionCards",
    pos = {x = 0, y = 0},
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		return { 
            vars = { card.ability.extra.xmult }
        }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                return{
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end

}

SMODS.Joker{
    key = "cinna",
    config = { extra = {numerator = 1, denominator = 4} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'cinna_destroy')
		return { vars = {new_numerator, new_denominator} }
    end,
    rarity = 2,
    atlas = "MintConditionCards",
    pos = {x = 2, y = 1},
    cost = 7,
    calculate = function(self, card, context)
        if context.before then
            for k, val in ipairs(context.scoring_hand) do
                if (not (SMODS.has_enhancement(val, 'm_steel') or SMODS.has_enhancement(val, 'm_gold'))) then
                    if SMODS.pseudorandom_probability(val, 'cinna_destroy', card.ability.extra.numerator, card.ability.extra.denominator, 'cinna_destroy') then
                        val.cinna_destroy_flag = true
                    end
                end
            end
        end
        if context.after then
            for k, val in ipairs(context.scoring_hand) do
                if val.cinna_destroy_flag == true then
                    SMODS.destroy_cards(val)
                end
            end
        end
    end
}

--[[ don't know what to do with this joker tbh
SMODS.Joker{
    key = "revenant",
    rarity = 2,
    atlas = "MintConditionCards",
    pos = {x = 1, y = 0},
    cost = 8,
} ]]--

SMODS.Joker{
    key = "birus",
    config = {extra = {deduction = 1} },
    loc_vars = function (self,info_queue,card)
        return {vars = {card.ability.extra.deduction}}
    end,
    rarity = 4,
    blueprint_compat = true,
    atlas = "MintConditionCards",
    pos = {x = 2, y = 0},
    soul_pos = {x = 3, y=0},
    cost = 20,
    calculate = function (self, card, context)
        if context.selling_self then
            ease_ante(-card.ability.extra.deduction)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction
        end
    end
}

SMODS.Joker{
    key = "lifesteal",
    config = { extra = {chip_gain= 15, chips = 0} },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chip_gain, card.ability.extra.chips} }
    end,
    rarity = 2,
    blueprint_compat = true,
    atlas = "MintConditionCards",
    pos = {x = 4, y = 0},
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            return{
                mult = card.ability.extra.chips,
            }
        end

        if context.remove_playing_cards and not context.blueprint then
            local destroyedcards = 0
            for k, val in ipairs(context.removed) do
                destroyedcards = destroyedcards + 1
            end
            if destroyedcards > 0 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain * destroyedcards
            end
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
            }
        end
    end
}

SMODS.Joker{
    key = "starwish",
    rarity = 3,
    atlas = "MintConditionCards",
    pos = {x = 5, y = 0},
    cost = 6,
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.upgrade_hand then
            level_by = level_by + 1

            return {
                card = card,
                message = '+1 Level'
            }
        end
    end
    
}

local original_level_up_hand = level_up_hand
function level_up_hand(card, hand, instant, amount)
    level_by = amount or 1

    SMODS.calculate_context( {upgrade_hand = (level_by > 0)} )

    original_level_up_hand(card, hand, instant, level_by)
end


SMODS.Joker{
    key = "coffeecup",
    config = { extra = {xmult = 1, currentxmult = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * (G.GAME.coffeecup_xmult or 0) + 1} }
    end,
    blueprint_compat = true,
    rarity = 1,
    atlas = "MintConditionCards",
    pos = {x = 6, y = 0},
    cost = 4,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.currentxmult + card.ability.extra.xmult * (G.GAME.coffeecup_xmult or 0)
            }
        end
        if context.selling_self and not context.blueprint then
            G.GAME.coffeecup_xmult = (G.GAME.coffeecup_xmult or 0) + 1
        end
    end
}

SMODS.Joker{
    key = "bowlingpins",
    config = { extra = {addxmult = 1, countcards = 10, xmult = 1, numberarray = {}} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.addxmult, card.ability.extra.countcards, card.ability.extra.xmult} }
    end,
    rarity = 3,
    atlas = "MintConditionCards",
    pos = {x = 7, y = 0},
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and next(context.poker_hands['Straight']) and not context.blueprint then
            local x = 1
            local uniquenumber = true
            for index, value in ipairs(card.ability.extra.numberarray) do
                if value == context.other_card:get_id() then
                    uniquenumber = false
                    break
                end
            end
            if uniquenumber == true then
                table.insert(card.ability.extra.numberarray, context.other_card:get_id())
            end
            if #card.ability.extra.numberarray == 10 then
                card.ability.extra.numberarray = {}
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.addxmult
                return{
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
            card.ability.extra.countcards = 10 - #card.ability.extra.numberarray
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{
    key = "gun",
    config = { extra = {extra = 5, extracount = 5} },
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra.extra, card.ability.extra.extracount}}
    end,
    rarity = 4,
    atlas = "MintConditionCards",
    pos = {x = 4, y = 1},
    soul_pos = {x = 5, y=1},
    cost = 20,
    add_to_deck = function (self,card,from_defbuff)
        SMODS.change_free_rerolls(card.ability.extra.extracount)
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            card.ability.extra.extracount = 5
        end
        if (context.starting_shop or context.reroll_shop) and (G.shop and not G.GAME.shop_free) then
            for k, v in pairs(G.shop_jokers.cards) do
                v.ability.couponed = true
                v:set_cost()
            end
        end
        if context.reroll_shop then
            card.ability.extra.extracount = card.ability.extra.extracount - 1
            G.FUNCS.can_reroll = function(e)
                if G.GAME.current_round.reroll_cost > 0 then
                    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
                    e.config.button = nil
                end
            end
        end
    end,
    remove_from_deck = function (self, card, from_defbuff)
        SMODS.change_free_rerolls(-card.ability.extra.extra)
    end
}

SMODS.Joker{
    key = "bowlingball",
    config = { extra = {addxmult = 0.5, xmult = 1} },
    loc_vars = function (self, info_queue, card)
        return{ vars = {card.ability.extra.addxmult, card.ability.extra.xmult}}
    end,
    blueprint_compat = true,
    rarity = 3,
    atlas = "MintConditionCards",
    pos = {x = 8, y = 0},
    cost = 8,
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:get_id() == 10 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.addxmult
                return{
                    message = 'Upgraded!'
                }

			end
		end
        if context.joker_main then
            return{
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = 1
            return{
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
	end
}

--[[
SMODS.Joker{
    key = "graphicalerror",
    loc_txt = {
        name = "Graphical Error",
        text = {
            "Copies of this Joker may show up",
            "in the {C:attention} Shop.{}",
            "Purchasing these copies {C:red}destroys{}",
            "the copy and gives ",
            "{C:inactive, s:0.8}(Currently {C:mult}+#3#{C:inactive} Mult){}"
        },
    },
    config = { extra = {min = 6, max = 39, total = 0} },
    rarity = 3,
    atlas = "MintConditionCards",
    pos = {x = 0, y = 1},
    cost = 8,
} 
]]--

SMODS.Joker{
    key = "split",
    config = { extra = {xmult = 2.5} },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult} }
    end,
    blueprint_compat = true,
    rarity = 3,
    atlas = "MintConditionCards",
    pos = {x = 1, y = 1},
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            local hasSeven = false
            local hasTen = false
            for k, val in ipairs(context.scoring_hand) do
                if val:get_id() == 7 then
                    hasSeven = true
                end
                if val:get_id() == 10 then
                    hasTen = true
                end
            end
            if hasSeven == true and hasTen == true then
                return{
                    xmult = card.ability.extra.xmult
                }                
            end
        end
    end
}



SMODS.Joker{
    key = "yjokera",
    config = { extra = {retriggers = 2} },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retriggers} }
    end,
    rarity = 3,
    atlas = "MintConditionCards",
    pos = {x = 3, y = 1},
    cost = 7,
    calculate = function (self, card, context)
        if context.cardarea == G.play and context.repetition and context.other_card:get_id() == 14 then
            return {repetitions = card.ability.extra.retriggers}
        end
        --[[ if context.after then
            for k, val in ipairs(context.scoring_hand) do
                if val:get_id() == 14 then
                    SMODS.destroy_cards(val)
                end
            end
        end --]]
        -- downside deemed unnecessary --
    end
}

SMODS.Sound{
    key = "richardwin",
    path = "richard_high_score.wav"
}
SMODS.Joker{
    key = "richard",
    loc_vars = function (self, info_queue, card)
        return {vars = {colours = {HEX("A1A5A9")}}}
    end,
    rarity = 2,
    blueprint_compat = true,
    atlas = 'MintConditionCards',
    pos = {x= 6, y = 1},
    pixel_size = {h = 62},
    cost = 7,
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'calculator',
                                key_append = 'mintconditioncards_richard'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_calculator'), colour = HEX("A1A5A9") },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end,
}
local original_win_game = win_game
function win_game()
    play_sound('mintconditioncards_richardwin')
    original_win_game()
end

SMODS.Joker{
    key = "dendri",
    config = {extra = {addhandsize = 1, handsize = 0}},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        local additionalhands = 0
        if G.jokers then
            for i=1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                if (joker.edition and joker.edition.key == "e_negative") then
                    additionalhands = additionalhands + card.ability.extra.addhandsize
                end
                if joker.config.center.key == "j_mintconditioncards_dendri" then
                    additionalhands = additionalhands + card.ability.extra.addhandsize
                end
            end
            card.ability.extra.handsize = additionalhands
            return { vars = {card.ability.extra.addhandsize, card.ability.extra.handsize}}
        else
            return { vars = {card.ability.extra.addhandsize, 1}}
        end
    end,
    rarity = 4,
    cost = 20,
    atlas = "MintConditionCards", pos = {x = 1, y = 2}, soul_pos = {x = 2, y = 2},
    add_to_deck = function (self, card, from_debuff)
        G.hand:change_size(card.ability.extra.handsize + 1)
    end,
    calculate = function (self, card, context)
        if context.card_added and context.card.ability.set == "Joker" then -- When a  Negative Joker/Dendri is added
            if (context.card.edition and context.card.edition.key == "e_negative") then
                G.hand:change_size(card.ability.extra.addhandsize)
            end
            if context.card.config.center.key == "j_mintconditioncards_dendri" then
                G.hand:change_size(card.ability.extra.addhandsize)
            end
        end
        if (context.edition and context.edition == "e_negative" or (type(context.edition) == "table" and context.edition.negative)) and context.card.ability.set == "Joker" then -- When a joker becomnes negative
            G.hand:change_size(card.ability.extra.addhandsize)
        end
        if context.selling_card and context.card.ability.set == "Joker" then -- When a Negative Joker/Dendri is sold, subtract hand size.
            if (context.card.edition and context.card.edition.key == "e_negative") then
                G.hand:change_size(-card.ability.extra.addhandsize)
            end
            if context.card.config.center.key == "j_mintconditioncards_dendri" then
                G.hand:change_size(-card.ability.extra.addhandsize)
            end
        end
    end,
}
local set_edition_ref = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
    SMODS.calculate_context{edition = edition, card = self}
    set_edition_ref(self, edition, immediate, silent, delay)
end

SMODS.Sound{
    key = 'scouter1006',
    path = "it's_1006.wav"
}

SMODS.Joker{
    key = "scouter",
    config = { extra = {plushand = 2, breakscore = 9000} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.plushand, card.ability.extra.breakscore} }
    end,
    rarity = 1,
    cost = 6,
    atlas = 'MintConditionCards',
    pos = {x = 7, y = 1},
    add_to_deck = function (self, card, from_debuff)
        G.hand:change_size(card.ability.extra.plushand)
    end,
    calculate = function (self, card, context)
        if context.after then
            local handscore = hand_chips * mult
            if handscore > card.ability.extra.breakscore then
                SMODS.destroy_cards(card)
                return {message = localize('k_over_9000'), colour = G.C.RED}
            elseif handscore == 1006 then
                play_sound('mintconditioncards_scouter1006')
            end
        end
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.plushand)
    end
}

SMODS.Joker{
    key = "remedy",
    config = {extra = {addxmult = 0.01, xmult = 0.99}},
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.addxmult, card.ability.extra.xmult}}
    end,
    rarity = 2,
    cost = 7,
    atlas = "MintConditionCards", pos = {x = 0, y = 2},
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Hearts') then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.addxmult
            end
            if context.other_card:is_suit('Clubs') then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.addxmult
            end
        end
        if context.joker_main then
            return{
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{
    key = "melodramatic",
    config = {extra = {addxmult = 0.1, stacks = 0,}},
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.addxmult, 1 + (card.ability.extra.addxmult * card.ability.extra.stacks)}}
    end,
    rarity = 2,
    cost = 8,
    atlas = "MintConditionCards", pos = {x = 4, y = 2},
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Hearts') then
                if card.ability.extra.addxmult * card.ability.extra.stacks ~= 0 then
                return {
                    xmult = 1 + card.ability.extra.addxmult * card.ability.extra.stacks,
                    func = function()
                        card.ability.extra.stacks = 0
                    end
                }
                end
            else
                if not context.blueprint then
                    card.ability.extra.stacks = card.ability.extra.stacks + 1
                end
            end
        end
    end
}

SMODS.Joker{
    key = "majestic",
    config = {extra = {addmoney = 1, stacks = 0}},
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.addmoney, (card.ability.extra.addmoney * card.ability.extra.stacks)}}
    end,
    rarity = 2,
    cost = 8,
    atlas = "MintConditionCards", pos = {x = 5, y = 2},
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                if card.ability.extra.addmoney * card.ability.extra.stacks ~= 0 then
                    return {
                    dollars = card.ability.extra.addmoney * card.ability.extra.stacks,
                    func = function()
                        card.ability.extra.stacks = 0
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
                end
            else
                if not context.blueprint then
                    card.ability.extra.stacks = card.ability.extra.stacks + 1
                end
            end
        end
    end
}

SMODS.Joker{
    key = "malicious",
    config = {extra = {addtarot = 1, stacks = 0}},
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.addtarot, (card.ability.extra.addtarot * card.ability.extra.stacks)}}
    end,
    rarity = 2,
    cost = 8,
    atlas = "MintConditionCards", pos = {x = 6, y = 2},
    blueprint_compat = true,
    calculate = function (self, card, context)  
        if context.before then
            Malnoreactiveate = false
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit ("Spades") then
            local eval = function() return context.after and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            if Malnoreactiveate == false then
                Malnoreactiveate = true
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.PURPLE
                }
            end
        end
        if context.joker_main then
            local malcheck = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_suit('Spades') and not context.blueprint then
                    malcheck = true
                end
            end
            if malcheck == true then
                if card.ability.extra.stacks > 0  then
                    local stacksubtract = 0
                    for i = 1, math.min(card.ability.extra.addtarot * card.ability.extra.stacks, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            SMODS.add_card {
                                                set = 'Tarot',
                                                key_append = 'mintconditioncards_malicious'
                                            }
                                            G.GAME.consumeable_buffer = 0
                                            return true
                                        end
                                    }))
                                    SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE },
                                        context.blueprint_card or card)
                                    return true
                                end)
                            }))
                            stacksubtract = stacksubtract + 1
                        end
                    end
                    card.ability.extra.stacks = card.ability.extra.stacks - stacksubtract
                end
            else
                if not context.blueprint then
                    card.ability.extra.stacks = card.ability.extra.stacks + 1
                end
            end
        end
    end
}

SMODS.Joker{
    key = "manic",
    config = {extra = {addlevels = 1, rounds = 2, left = 2, stacks = 0}},
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.addlevels, card.ability.extra.rounds, card.ability.extra.left, (card.ability.extra.addlevels * card.ability.extra.stacks)}}
    end,
    rarity = 2,
    cost = 8,
    atlas = "MintConditionCards", pos = {x = 7, y = 2},
    blueprint_compat = true,
    calculate = function (self, card, context)
        if context.before then
            local manicheck = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_suit('Clubs') and not context.blueprint then
                    manicheck = true
                end
            end
            if manicheck == true then
                if card.ability.extra.stacks > 0  then
                    return{
                        message = localize('k_level_up_ex'),
                        level_up = card.ability.extra.addlevels * card.ability.extra.stacks,
                        func = function ()
                            card.ability.extra.stacks = 0
                        end
                    }
                end
            else
                if not context.blueprint then
                    if card.ability.extra.left <=1 then
                        card.ability.extra.stacks = card.ability.extra.stacks + 1
                        card.ability.extra.left = card.ability.extra.rounds
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CLUBS,
                        }
                    else
                        card.ability.extra.left = card.ability.extra.left - 1
                    end

                end
            end
        end
    end
}


