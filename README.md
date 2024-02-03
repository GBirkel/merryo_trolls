# Super Merryo Trolls # 

**An Adventure From The Days Before VRAM**

It's the year 1991. You're a teenage computer geek. You've just upgraded to your first "16-bit" computer, and the possibilities are dazzling. To relieve the crushing boredom of your High School coursework, you and your friends embark on the computer geek equivalent of forming a heavy metal band: You create your own video game.

You meet on the benches during lunch hour, and pass around crude plans scribbled on graph paper. You assign each other impressive titles like "Master Programmer", "Sound Designer", and "Area Data Input". You draw circles and arrows all over fuzzy dot-matrix printouts of code, and argue over them between episodes of "Ren and Stimpy". You swap 3.5" disks around like furtive secret agents. You consume incredible quantities of soda. Your parents look at your owlish eyes - and possibly your slipping grades - and wonder aloud if you're "on drugs".

If the above sounds familiar to you, then the rest of this article may prove interesting.  It's the source code to the Apple IIgs game my friends and I started - but didn't finish - in high-school.  Thanks to emulators and modern versions of ancient development tools, you can actually compile and run this game, in its not-quite-finished form.

For a lot more background, as well as a walkthrough of how the code works and what could be considered innovative about it, check out [this writeup](http://garote.bdmonkeys.net/merryo_trolls/index.html).

## Getting Started ##

You need two external tools to make this work:

The [Merlin32 assembler](https://brutaldeluxe.fr/products/crossdevtools/merlin/index.html), for building the code.
The [CiderPress II](https://ciderpress2.com) utility, for constructing the a disk image suitable for running with an Apple IIgs.

Download and install these somewhere near your checked-out copy of this repo, then modify `build.sh` to point to these tools.

Note that if you're on MacOS you may need to de-quarantine these tools before the build script can launch them, by going into their folders and running `sudo xattr -r -d com.apple.quarantine *` .

