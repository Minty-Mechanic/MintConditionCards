SMODS.current_mod.calculate = function (self, context)

    --Jumbo Josh Pack opening sound--
    if context.open_booster and context.card.config.center.key == "p_mintconditioncards_JumboJoshPack" then
        play_sound("mintconditioncards_openjosh")
    end

    --Hatchet "Undebuffing" ability removal at end of blind--
    if context.end_of_round then
        for index, playing_card in ipairs(G.playing_cards) do
            playing_card.hatchet_undebuff = false
        end
    end

    -- Paddle functionality --
    if context.final_scoring_step and Paddlebalancecheck == true then
        Paddlebalancecheck = false
        return {
            balance = true
        }
    end
end