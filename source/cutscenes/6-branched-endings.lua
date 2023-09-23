-- this is the data for one SEQUENCE

scene6 = {
	title = "Scene 6: Branched Endings",

	showAdvanceControls = false,
	advanceControls = {
		-- normally `target` specifies the sequence to advance to
		-- but if this is the final sequence in your cutscene you can 
		-- set `target` to a string that will get sent back to your game
		
		{ input = Panels.Input.A, target = 1 }, 
		{ input = Panels.Input.B, target = "decline" } 
	},

	panels = {
		{ -- panel 1
			layers = {
				{ text = "Scene 6", x = 50, y = 100 },
				{ text = "Branched Endings", x = 50, y = 130 }
			}
		},
		{ -- panel 2
			layers = {
				{ image = "examples/ex1/sky.png", parallax = 1 },
				{ image = "examples/ex1/1-mountains.png", parallax = 0.8 },
				{ image = "examples/ex1/1-horizon.png", parallax = 0.7 },
				{ image = "examples/ex1/1-city.png", parallax = 0.6 },
				{ image = "examples/ex1/1-ledge.png", parallax = 0.3 },
				{ image = "examples/ex1/1-man.png", parallax = 0.2 },
			},
		},
		{ -- panel 3
			layers = {
				{ image = "examples/ex1/sky.png", parallax = 1 },
				{ image = "examples/ex1/1-mountains.png", parallax = 0.8 },
				{ image = "examples/ex1/2-ledge.png", parallax = 0.3 },
				{ image = "examples/ex1/2-phone.png", parallax = 0.2 },
			},
		},
		{ -- panel 4
			layers = {
				{ text = "Press *A* to answer", x = 50, y = 100 },
				{ text = "Press *B* to decline", x = 50, y = 150 }
			}
		}
	}
}
