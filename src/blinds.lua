SMODS.Atlas{
    key = "MintConditionBlinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
}



-- The Idiot --
SMODS.Blind{
    key = 'idiot',
    dollars = 5,
    mult = 3,
    atlas = "MintConditionBlinds",
    pos = {x = 0, y = 0},
    boss = {min = 1},
    boss_colour = HEX("07B2B9"),
    calculate = function (self, blind, context)
        if not blind.disabled then
            if context.after then
                if G.GAME.current_round.hands_played == 0 then
                    G.FUNCS.overlay_menu{definition = create_UIBox_custom_video2("triple baka", "baka.", 236), config = {no_esc = true}}
                else
                    G.FUNCS.overlay_menu{definition = create_UIBox_custom_video2("triple baka", "you get the idea now, baka.", 8), config = {no_esc = true}}
                end
            end
        end
    end
}

-- Copper Cutlass --
SMODS.Blind{
    key = 'final_cutlass',
    dollars = 8,
    mult = 2,
    atlas = "MintConditionBlinds",
    pos = {x = 0, y = 1},
    boss = {showdown = true},
    boss_colour = HEX("B15915"),
    calculate = function (self, blind, context)
        if not blind.disabled then
            if context.press_play then
                for i = 1, #G.hand.cards do
                    if not G.hand.cards[i].highlighted then
                        local slice_card = G.hand.cards[i]
                        slice_card.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.juice_up_blind()
                                slice_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                                play_sound('slice1', 0.96 + math.random() * 0.08)
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}