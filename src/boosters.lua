SMODS.Atlas{
    key = "MintConditionBoosters",
    path = "boosters.png",
    px = 71,
    py = 95
}
SMODS.Sound{
    key = "openjosh",
    path = "i_m_jumbo_josh_brah.wav"
}
--Mint Condition--
SMODS.ObjectType{
    key="MintCondition",
    default = "j_mintconditioncards_millicent",
    cards = {
        j_mintconditioncards_millicent = true,
        j_mintconditioncards_revenant = true,
        j_mintconditioncards_lifesteal = true,
        j_mintconditioncards_starwish = true,
        j_mintconditioncards_coffeecup = true,
        j_mintconditioncards_bowlingpins = true,
        j_mintconditioncards_bowlingball = true,
        j_mintconditioncards_graphicalerror = true,
        j_mintconditioncards_split = true,
        j_mintconditioncards_cinna = true,
        j_mintconditioncards_yjokera = true,
        j_mintconditioncards_richard = true,
        j_mintconditioncards_scouter = true,
        j_mintconditioncards_remedy = true,
        j_mintconditioncards_melodramatic = true,
        j_mintconditioncards_majestic = true,
        j_mintconditioncards_malicious = true,
        j_mintconditioncards_manic = true,
    }
}

SMODS.Booster{
    key = "MintConditionPack1",
    group_key = "k_MintConditionPack",
    config = {extra = 2, choose = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose}}
    end,
    weight = 0.6,
    atlas = 'MintConditionBoosters',
    pos = {x = 0, y = 0},
    cost = 4,
    kind = "MintCondition",
    pools = {["mintconditioncards_MintCondition"] = true},
    create_card = function (self, card, i)
        return {set = "MintCondition"}
    end
}
SMODS.Booster{
    key = "MintConditionPack2",
    group_key = "k_MintConditionPack",
    config = {extra = 2, choose = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose}}
    end,
    weight = 0.6,
    atlas = 'MintConditionBoosters',
    pos = {x = 1, y = 0},
    cost = 4,
    kind = "MintCondition",
    pools = {["mintconditioncards_MintCondition"] = true},
    create_card = function (self, card, i)
        return {set = "MintCondition"}
    end
}
SMODS.Booster{
    key = "JumboMintConditionPack",
    group_key = "k_MintConditionPack",
    config = {extra = 4, choose = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose}}
    end,
    weight = 0.6,
    atlas = 'MintConditionBoosters',
    pos = {x = 2, y = 0},
    cost = 6,
    kind = "MintCondition",
    pools = {["mintconditioncards_MintCondition"] = true},
    create_card = function (self, card, i)
        return {set = "MintCondition"}
    end
}
SMODS.Booster{
    key = "MegaMintConditionPack",
    group_key = "k_MintConditionPack",
    config = {extra = 4, choose = 2},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose,}}
    end,
    weight = 0.15,
    atlas = 'MintConditionBoosters',
    pos = {x = 3, y = 0},
    cost = 8,
    kind = "MintCondition",
    pools = {["mintconditioncards_MintCondition"] = true},
    create_card = function (self, card, i)
        return {set = "MintCondition"}
    end
}
--Calculator--
SMODS.Booster{
    key = "CalculatorPack1",
    group_key = "k_CalculatorPack",
    config = {extra = 3, choose = 1},
    loc_vars = function (self, info_queue, card)
    return {vars = { card.ability.extra, card.ability.choose,
            colours = {
                HEX("A1A5A9")
            }}}
    end,
    weight = 0.8,
    atlas = 'MintConditionBoosters',
    pos = {x = 0, y = 1},
    cost = 4,
    kind = "MintCondition",
    pools = {["mintconditioncards_calculator"] = true},
    select_card = 'consumeables',
    create_card = function (self, card, i)
        return {set = "calculator", skip_materialize = true}
    end
}
SMODS.Booster{
    key = "CalculatorPack2",
    group_key = "k+CalculatorPack",
    config = {extra = 3, choose = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose,
                colours = {
                    HEX("A1A5A9")
                }}}
    end,
    weight = 0.8,
    atlas = 'MintConditionBoosters',
    pos = {x = 1, y = 1},
    cost = 4,
    kind = "Calculator",
    pools = {["mintconditioncards_calculator"] = true},
    select_card = 'consumeables',
    create_card = function (self, card, i)
        return {set = "calculator", skip_materialize = true}
    end
}
SMODS.Booster{
    key = "JumboCalculatorPack",
    group_key = "k_CalculatorPack",
    config = {extra = 5, choose = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose,
                colours = {
                    HEX("A1A5A9")
                }}}
    end,
    weight = 0.6,
    atlas = 'MintConditionBoosters',
    pos = {x = 2, y = 1},
    cost = 6,
    kind = "Calculator",
    pools = {["mintconditioncards_calculator"] = true},
    select_card = 'consumeables',
    create_card = function (self, card, i)
        return {set = "calculator", skip_materialize = true}
    end
}
SMODS.Booster{
    key = "MegaCalculatorPack",
    group_key = "k_CalculatorPack",
    config = {extra = 5, choose = 2},
    loc_vars = function (self, info_queue, card)
        return {vars = { card.ability.extra, card.ability.choose,
                colours = {
                    HEX("A1A5A9")
                }}}
    end,
    weight = 0.3,
    atlas = 'MintConditionBoosters',
    pos = {x = 3, y = 1},
    cost = 8,
    kind = "Calculator",
    pools = {["mintconditioncards_calculator"] = true},
    select_card = 'consumeables',
    create_card = function (self, card, i)
        return {set = "calculator", skip_materialize = true}
    end
}
--Jumbo Josh--
SMODS.Booster{
    key = "JumboJoshPack",
    group_key = "k_JumboJoshPack",
    config = {extra = 4, choose = 1},
    loc_vars = function (self, info_queue, card)
    return {vars = { card.ability.extra, card.ability.choose}}
    end,
    weight = 0.2,
    atlas = 'MintConditionBoosters',
    pos = {x = 4, y = 0},
    cost = 8,
    select_card = 'consumeables',
    create_card = function (self, card, i)
        local index = math.fmod(i, #SMODS.ConsumableType.ctype_buffer)   -- Establishes index as the pack slot divided by the number of consumeables (slot 1 = Tarots, slot 2 = Planets, etc.)
        if index == 0 then
            index = #SMODS.ConsumableType.ctype_buffer  -- If all consumable types have been looped through, return to the beginning of the consumeable list.
        end
        return {set = SMODS.ConsumableType.ctype_buffer[index], skip_materialize = true}
    end
}