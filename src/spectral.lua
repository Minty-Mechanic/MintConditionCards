SMODS.Atlas{
    key = "MintConditionConsumeables",
    path = "consumeables.png",
    px = 71,
    py = 95
}
--Parallel Dimension--
SMODS.Consumable{
    key = "parallel";
    set = "Spectral";
    config = {},
    atlas = "MintConditionConsumeables",
    pos = {x = 0, y = 0},
    cost = 3,
    can_use = function(self, card)
        Parallels1 = {"j_joker", "j_greedy_joker", "j_rough_gem", "j_gluttenous_joker", "j_onyx_agate", "j_jolly", "j_zany", "j_mad", "j_crazy", "j_droll", "j_odd_todd", "j_smiley", "j_business", "j_blueprint", "j_juggler", "j_drunkard", "j_lucky_cat", "j_runner", "j_bull", "j_baron", "j_seeing_double", "j_rocket", "j_sixth_sense", "j_gros_michel", "j_ice_cream", "j_fortune_teller", "j_red_card", "j_sock_and_buskin", "j_luchador", "j_cartomancer", "j_mintconditioncards_millicent", "j_mintconditioncards_bowlingpins", "j_mintconditioncards_melodramatic", "j_mintconditioncards_malicious"}
        Parallels2 = {"j_misprint","j_lusty_joker", "j_bloodstone", "j_wrathful_joker", "j_arrowhead", "j_sly", "j_wily", "j_clever", "j_devious", "j_crafty", "j_even_steven", "j_scary_face", "j_reserved_parking", "j_brainstorm", "j_troubadour", "j_merry_andy", "j_glass", "j_trousers", "j_bootstraps","j_shoot_the_moon", "j_flower_pot", "j_sattelite", "j_seance", "j_cavendish", "j_popcorn", "j_constellation", "j_flash", "j_hack", "j_matador", "j_astronomer", "j_mintconditioncards_cinna", "j_mintconditioncards_bowlingball", "j_mintconditioncards_majestic", "j_mintconditioncards_manic"}
        local foundparallel = false
        if #G.jokers.highlighted == 1 then
            for i = 1, #Parallels1 do
                if G.jokers.highlighted[1].config.center.key == Parallels1[i] then
                    foundparallel = true
                    ParallelSide = 1
                    return true;
                end
            end
            if foundparallel == false then
                for i = 1, #Parallels2 do
                    if G.jokers.highlighted[1].config.center.key == Parallels2[i] then
                        ParallelSide = 2
                        return true;
                    end
                end
            end
            if foundparallel == false then
               return false 
            end
        else
            return false;
        end
    end;
    use = function (self, card, context)
        card = G.jokers.highlighted[1]
        local paraindex
        for i = 1, #Parallels1 do
            if ParallelSide == 1 then
                if card.config.center.key == Parallels1[i] then
                    paraindex = i
                end
            else
                if card.config.center.key == Parallels2[i] then
                    paraindex = i
                end
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.jokers.highlighted[1]:flip();play_sound('card1', 1);G.jokers.highlighted[1]:juice_up(0.3, 0.3);return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.1,
            func = function ()
                if ParallelSide == 1 then
                card:set_ability(Parallels2[paraindex])
                else
                card:set_ability(Parallels1[paraindex])
                end
            return true end
        }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.jokers.highlighted[1]:flip();play_sound('tarot2', 1, 0.6);G.jokers.highlighted[1]:juice_up(0.3, 0.3);return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.jokers:unhighlight_all(); return true end }))


    end
}
--Clear--
SMODS.Consumable{
    key = 'clear',
    set = "Spectral",
    config = {},
    pixel_size = {h = 62},
    atlas = "MintConditionConsumeables",
    pos = {x=3,y=3},
    cost = 3,
    hidden = true,
    soul_set = 'calculator',
    soul_rate = '0.001',
    can_repeat_soul = false,
    can_use = function(self, card)
        if G.STATE == G.STATES.SELECTING_HAND then
            return true
        end
    end,
    use = function (self, card, area, copier)
        G.GAME.chips = G.GAME.blind.chips
        G.STATE = G.STATES.HAND_PLAYED
        G.STATE_COMPLETE = true
        end_round()
        G.hand = false
    end 
}

