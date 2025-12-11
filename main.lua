SMODS.Atlas{
    key = 'modicon',
    path = 'modicon.png',
    px = 32,
    py = 32,
}

SMODS.Atlas{
    key = 'mcc_splash',
    path = 'tscreenlogo.png',
    px = 117,
    py = 97
}

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/spectral.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/calculator.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file)("src/blinds.lua")()
assert(SMODS.load_file)("src/mediaplayer.lua")()
assert(SMODS.load_file("src/currentmodcalc.lua"))()