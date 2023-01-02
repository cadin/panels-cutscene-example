# Panels Cutscene Example

An example project demonstrating how to use [Panels](https://github.com/cadin/panels) comics as cutscenes within your game.

## Setup

This project includes the Panels framework as a git submodule. Be sure to properly [initialize the submodule](https://www.w3docs.com/snippets/git/how-to-clone-including-submodules.html) when cloning the repo.

If you're not using git, you can download this code as a ZIP file. In that case you'll also need to download the code from the [Panels repo](https://github.com/cadin/panels) and place it in the `source/libraries/panels/` folder of this template.

## Usage

-   Import Panels
-   When you want to start a cutscene, call `Panels.startCutscene(data, callback)` where `data` is the [`comicData`](https://cadin.github.io/panels/docs/comic-data/) for the entire cutscene and `callback` is a function in your game that will be called when the cutscene finishes.
-   While the cutscene is running (until your callback is called) call `Panels.update()` from your main [Playdate update loop](https://sdk.play.date/1.12.3/Inside%20Playdate.html#c-update).
-   When the cutscene completes, simply stop calling `Panels.update()`.

## Example Game

-   `Dpad` to move the box on screen
-   `A` button to trigger cutscene and move to the next level of the game
