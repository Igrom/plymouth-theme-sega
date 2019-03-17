# plymouth-theme-sega
![Example](https://raw.githubusercontent.com/Igrom/plymouth-theme-sega/master/examples/plymouth-theme-sega.gif)

Generate a Plymouth theme to spoof the SEGA 'glint' animation using a custom logo. Based on [this video](https://www.youtube.com/watch?v=kLVelULW1zE).

`plymouth-theme-sega` uses [sega-animation-generator](https://github.com/Igrom/sega-animation-generator) to generate an glint/fade-in animation, then renders an accompanying Plymouth `script` from a template.

Customizable parameters are the same as in `sega-animation-generator`:
- text
- font, font size and color
- glint and fade-in animation speed

with two new ones:

- idle animation length (logo shown in full opacity on screen)
- fade-out animation speed

## How to run
The tool depends on sega-animation-generator and its dependencies, and `make`. In addition, you need to install `plymouth-x11` if you'd like to test the animation without restarting your computer.

Clone the repository, then run:
```bash
make
```
 to generate the animation and the `sega.script` file.

Alternatively, run:
```bash
make sega.script
```
 to generate just the script. Useful if you already have a custom animation you'd like to use.

Next, run:
```bash
sudo make install
```
 to install the theme in the default Plymouth themes folder. Once this is done, you will have to manually enable the theme. This involves configuring Plymouth to use the new theme and rebuilding your initial ramdisk image. The exact steps may depend on your distribution.  Helpful instructions along with a catch-all solution are printed at the end of the console output.

## How to test the theme without restarting your computer
Is your theme installed and enabled right? Run:
```bash
sudo make test
```
 to check. The splash screen will display and disappear after several seconds. The screen refreshes only when external input is provided by the user: continue to move your mouse during the animation to refresh the screen.

## How to uninstall
Run:
```bash
sudo make uninstall
```
to remove the theme. Note that this does not reconfigure Plymouth to use a different theme --- you have to take care of that yourself.

## Customization
Customize the values:
- ANIMATION\_GLINT\_FRAME\_COUNT
- ANIMATION\_FADEIN\_FRAME\_COUNT
- ANIMATION\_IDLE\_FRAME\_COUNT
- ANIMATION\_FADEOUT\_FRAME\_COUNT

in the Makefile. Don't forget to customize the values in the Makefile of `sega-animation-generator`.

## Problems
> Q: When I run `sudo make test`, nothing happens.
>
>  A: Ensure you have installed the package `plymouth-x11`.

> Q: When I run `sudo make test`, a different theme is displayed.
>
>  A: Configure Plymouth to use the new theme. Read the instructions contained in the file `Instructions` or at the end of the console output of `sudo make install`.

> Q: I can see the theme when running `sudo make test`, but a different theme is displayed when starting/shutting down the computer.
>
>  A: Rebuild your initial ramdisk image. A common command to accomplish this is `sudo update-initramfs -u`.

## Ideas for future development
The theme provides for the display of neither messages nor prompts. Rely on your gut feeling to enter your disk encrpytion passphrase. Features can be ported from other Ubuntu themes (e.g., ubuntu-logo) to remedy this.

## Author
Igor Sowinski \<igor@sowinski.blue\>

## COPYRIGHT
Copyright © 2019 Igor Sowinski.  Licensed under the 3-clause BSD license.
