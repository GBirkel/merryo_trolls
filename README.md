# Super Merryo Trolls # 

**An Adventure From The Days Before VRAM**

![Super Merryo Trolls Reference Gameplay Video](https://github.com/GBirkel/merryo_trolls/assets/17415530/0af357f1-59d1-4956-b599-1de9066f85e2)

It's the year 1991. You're a teenage computer geek.

You've just upgraded to your first "16-bit" computer, and the possibilities are infinite. To relieve the crushing boredom of your High School coursework, you and your friends embark on the computer geek equivalent of forming a heavy metal band: You create your own video game.

You meet on the benches during lunch hour, and pass around crude plans scribbled on graph paper. You assign each other impressive titles like "Master Programmer", "Sound Designer", and "Area Data Input". You draw circles and arrows all over fuzzy dot-matrix printouts of code, and argue over them between episodes of "Ren and Stimpy". You swap 3.5" disks around like furtive secret agents. You consume incredible quantities of soda. Your parents look at your owlish eyes - and possibly your slipping grades - and wonder aloud if you're "on drugs".

If that sounds familiar to you, then this project will be amusing.  It's the Apple IIgs game my friends and I started - but didn't finish - in high-school.  Thanks to emulators and modern versions of ancient development tools, you can actually compile and run this game, in its not-quite-finished form.

For a lot more background, and a tour through the bizarre code shenanigans we employed to make a console-style game playable on the notoriously slow Apple IIgs hardware, check out [this expanded writeup](http://garote.bdmonkeys.net/merryo_trolls/index.html).

## Giving it a whirl ##

2024 is a unique year to be resurrecting this game, and not just because it's the 30th anniversary of its death.  This year has seen the release of [Crossrunner](https://www.crossrunner.gs/), the very first <i>cycle accurate</i> emulator for the Apple IIgs.  Up until this point, Super Merryo Trolls either didn't launch at all in emulators, or was unplayably fast.  At long last you can now play this game in its original screen-tearing single-digit frames-per-second glory.

All you need is the [pre-built disk image](Merryo_Trolls.2mg) from this repo, and some kind of joystick device.  (The Apple IIgs supports analog joysticks but you can play it just fine with something simple like the <b>8Bitdo Zero 2 Mini Bluetooth Gamepad</b>.)  Double-click on the disk and Crossrunner will boot and launch the game.  At the title screen, hit "1" to start World 1.

## Further development ##

You can use this code as a starting point for your own work.  For me, any commercial use it may have here in the crazy future of 2024 is frankly <i>inconceivable</i>[^1], but if you find an angle, get in touch with me so I can congratulate you and mention it to my other two "co-developers" and we can all have a good laugh.

Meanwhile, you should know that in the process of stitching the levels from 1994 together into something playable, I wrote and included a set of modern game editing tools that run in any WebKit-based browser.

![Super Merryo Trolls Editor Video](https://github.com/GBirkel/merryo_trolls/assets/17415530/b63ca07d-a836-4533-9f75-61eb7410f18e)

They work directly on the various crude binary file formats that the game uses natively, and may be a good reference for similar forensics tools in other projects.

## Building the game from source ##

A build script is included that compiles all the assembly files, then copies all the assets onto a bootable disk image, resulting in something immediately playable.

You need two external tools to make this work:

* The [Merlin32 assembler](https://brutaldeluxe.fr/products/crossdevtools/merlin/index.html), for building the code.
* The [CiderPress II](https://ciderpress2.com) utility, for constructing the a disk image suitable for running with an Apple IIgs.

Both of these have Windows and Mac versions, and the build script that drives them is written in Python, so it's all theoretically cross-platform, but the script needs tweaking for a Windows environment.

Download and install these tools somewhere near your checked-out copy of this repo, then modify the paths in `build.sh` to point to them.

Note that on MacOS you may need to de-quarantine them first, by going into their folders and running `sudo xattr -r -d com.apple.quarantine *` .

With the right tools, you can take the resulting disk image and write it to an 800k 3.5-inch disk, and play the game on a stock Apple IIgs.

[^1]: But really, who knows what's possible? There's currently a land war in Asia going on.
