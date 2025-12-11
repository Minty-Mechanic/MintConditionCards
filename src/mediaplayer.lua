function create_UIBox_custom_video2(name, buttonname, duration)
    local file_path = SMODS.Mods["MintConditionCards"].path .. "/assets/" .. name .. ".ogv"
    local file = NFS.read(file_path)
    love.filesystem.write(name .. ".ogv", file)
    local video_file = love.graphics.newVideo(name .. ".ogv")
    local vid_sprite = Sprite(0, 0, 11 * 4 / 3, 11, G.ASSET_ATLAS["ui_" .. (G.SETTINGS.colourblind_option and 2 or 1)], {x = 0, y = 0})
    video_file:getSource():setVolume(G.SETTINGS.SOUND.volume * G.SETTINGS.SOUND.game_sounds_volume / (100 * 10))
    vid_sprite.video = video_file
    video_file:play()

    local n = create_UIBox_generic_options({
        back_delay = duration,
        back_label = buttonname,
        colour = G.C.BLACK,
        padding = 0,
        contents = {
            {n = G.UIT.O, config = {object = vid_sprite}}}
    })
    return n
end
--[[function create_fullscreen_video(name, duration)
    local file_path = SMODS.Mods["MintConditionCards"].path .. "/assets/" .. name .. ".ogv"
    local file = NFS.read(file_path)
    love.filesystem.write(name .. ".ogv", file)
    local width, height = love.window.getMode()
    local video_file = love.graphics.newVideo(name .. ".ogv")
    local vid_sprite = Sprite(0, 0, 1280/width, 720/height, G.ASSET_ATLAS["ui_" .. (G.SETTINGS.colourblind_option and 2 or 1)], {x = 0, y = 0})
    video_file:getSource():setVolume(G.SETTINGS.SOUND.volume * G.SETTINGS.SOUND.game_sounds_volume / (100 * 10))
    vid_sprite.video = video_file
    video_file:play()

    local n = create_UIBox_generic_options({
        back_delay = duration,
        back_label = 'buttonname',
        colour = G.C.BLACK,
        padding = 0,
        contents = {
        {n = G.UIT.O, config = {object = vid_sprite}}}
    })
    return n
end
--]]