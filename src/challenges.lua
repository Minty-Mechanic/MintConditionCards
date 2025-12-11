--Robbery--
SMODS.Challenge{
    key = "robbery",
    rules = {
        custom = {
            {id = 'money_limit', value = 10}
        }
    },
    jokers = {{id = 'j_mintconditioncards_gun', eternal = true}},
    restrictions = {
        banned_cards = {
            {id = "v_reroll_surplus"},
            {id = "v_reroll_glut"},
            {id = "j_chaos"}
        }
    }

}

-- "Money_Limit rule" --
local ease_dollars_ref = ease_dollars
function ease_dollars(mod, instant)
    if G.GAME.modifiers.money_limit and type(G.GAME.modifiers.money_limit) == "number" then
        mod = math.min (mod, G.GAME.modifiers.money_limit-G.GAME.dollars)
    end
    return ease_dollars_ref(mod, instant)
end

--Spin Control--
SMODS.Challenge{
    key = "spincontrol",
    rules = {
        modifiers = {
            {id = 'hands', value = 2},
            {id = 'discards', value = 1},
        },
    },
    jokers = {
        {id = 'j_mintconditioncards_bowlingpins', eternal = true},
        {id = 'j_mintconditioncards_bowlingball', eternal = true},
        {id = 'j_mintconditioncards_split', eternal = true}
        },
    restrictions = {
        banned_cards = {
            {id = 'v_grabber'},
            {id = 'v_nacho_tong'},
            {id = 'j_burglar'},
            {id = 'c_mintconditioncards_cross'}
        }
    },
    deck = {
        no_ranks = {
            K = true,
            Q = true,
            J = true
        }
    }
}

--TreasureTest--
SMODS.Challenge{
    key = "TreasureTest",
    loc_txt = {
        name = "TreasureTest"
    },
    deck = {
        type = 'Challenge Deck',
        cards = {{s = 'C', r = 'A'} }
    }
}

-- Challenge A (unused)--
--[[SMODS.Challenge{
    key = "challengea",
    jokers = {
        {id = 'j_mintconditioncards_yjokera', eternal = true}
    },
    deck = {
        type = "Challenge Deck",
        cards = {
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'C', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'D', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'H', r = 'A'},
            { s = 'S', r = 'A'},
            { s = 'S', r = 'A'},
            { s = 'S', r = 'A'},
            { s = 'S', r = 'A'},
        }
    }
}
--]]