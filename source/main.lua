-- IMPORT:
-- Panels is included as a submodule in this repo
-- if you don't see any files in libraries/panels
-- you may need to initialize the submodule
import "libraries/panels/Panels"

-- SETTINGS:
-- change any settings before calling `startCutscene()`
Panels.Settings.snapToPanels = false

-- CUTSCENE SEQUENCES:
-- look in the `cutscenes` folder for the data files
import "cutscenes/1-simple-comic.lua"
import "cutscenes/2-animation.lua"
import "cutscenes/3-image-transitions.lua"
import "cutscenes/4-custom-functions.lua"
import "cutscenes/5-audio.lua"

-- COMICDATA FOR CUTSCENES
-- these are the tables we'll send to Panels for the cutscenes
-- they contain sequences imported from the files above
local cutscene1Data = {
    scene1 -- single SEQUENCE
}

local cutscene2Data = {
    scene2a, scene2b -- this scene has two SEQUENCES
}

local cutscene3Data = {
    scene3a, scene3b -- this scene has two SEQUENCES
}

local cutscene4Data = {
    scene4 -- single SEQUENCE
}

local cutscene5Data = {
    scene5 -- single SEQUENCE
}

-- a list of all the cutscenes
local cutscenes = {
    cutscene1Data, cutscene2Data, cutscene3Data, cutscene4Data, cutscene5Data
}


-- -------------------------------
-- MAIN GAME
-- -------------------------------

-- VARS
-- some state for my simple game
-- most important thing here is the `cutsceneIsPlaying` flag
-- we'll use that to determine if we should update Panels or the main game
local cutsceneIsPlaying = false

local currentLevel = 1
local x = 100
local y = 100
local speed = 5


-- FUNCTIONS

-- called when Panels finishes playing the current cutscene
function cutsceneDidFinish()
    -- flip the flag OFF
    cutsceneIsPlaying = false

    -- reapply inputHandlers for main game (if used)
    -- playdate.inputHandlers.push(gameInputHandlers)

    -- increment the level
    currentLevel = currentLevel + 1
    if currentLevel > 5 then currentLevel = 1 end -- we only have 5 levels
end

-- called when a level is completed
function startCutscene()
    -- flip the flag ON
    cutsceneIsPlaying = true

    -- choose the cutscene data based on the current level
    local cutsceneNum = currentLevel
    local comicData = cutscenes[currentLevel]

    -- remove inputHandlers for the main game (if used)
    -- playdate.inputHandlers.pop()

    -- tell Panels to start the cutscene (with callback)
    Panels.startCutscene(comicData, cutsceneDidFinish)
end

-- simple game loop
-- move a box on screen
function updateGame()
    -- update the screen
    playdate.graphics.clear()
    playdate.graphics.drawText("*Level " .. currentLevel .. "*", 20, 10)
    playdate.graphics.drawText("Press A to complete level", 20, 210)
    playdate.graphics.drawRect(x, y, 10, 10)

    -- button input
    if (playdate.buttonIsPressed(playdate.kButtonUp)) then
        y = y - speed
    elseif playdate.buttonIsPressed(playdate.kButtonDown) then
        y = y + speed
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        x = x + speed
    elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
        x = x - speed
    end

    -- press the A button to complete the level
    if playdate.buttonJustPressed(playdate.kButtonA) then
        startCutscene()
    end
end

-- MAIN UPDATE LOOP
-- here we use the `cutsceneIsPlaying` flag to determine
-- whether we should update the main game or Panels
function playdate.update()
    if cutsceneIsPlaying then
        Panels.update()
    else
        updateGame()
    end
end

-- button callbacks still get called when Panels is active
-- probably best to trap for `cutsceneIsPlaying` to prevent
-- unwanted side effects in your game
function playdate.downButtonDown()
    if not cutsceneIsPlaying then
        print("down")
    end
end

-- function playdate.cranked()
--     print("crank")
-- end
