-- IMPORT:
-- Panels is included as a submodule in this repo
-- if you don't see any files in libraries/panels
-- you may need to initialize the submodule
import "libraries/panels/Panels"


-- EXAMPLE SEQUENCES:
-- look in the `examples` folder for the data files
import "examples/2-animation.lua"
import "examples/3-image-transitions"


-- COMICDATA FOR CUTSCENES
-- these are the tables we'll send to Panels for the cutscenes
local cutscene1Data = {
    example2a
}

local cutscene2Data = {
    example3a,
    example3b
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


-- called when Panels finishes playing the current cutscene
function cutsceneDidFinish()
    -- flip the flag OFF
    cutsceneIsPlaying = false

    -- reapply inputHandlers for main game
    -- playdate.inputHandlers.push(gameInputHandlers)

    -- increment the level
    currentLevel = currentLevel + 1
end

-- called when a level is completed
function startCutscene()
    -- flip the flag ON
    cutsceneIsPlaying = true

    -- choose the cutscene data based on the current level
    local comicData = cutscene1Data
    if currentLevel % 2 == 0 then
        comicData = cutscene2Data
    end

    -- remove inputHandlers for the main game
    -- playdate.inputHandlers.pop()

    -- tell Panels to start the cutscene (with callback)
    Panels.startCutscene(comicData, cutsceneDidFinish)
end

-- simple game loop
-- move a box on screen
function updateGame()
    playdate.graphics.clear()
    playdate.graphics.drawText("Level " .. currentLevel, 10, 10)
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
