# autohotkey-scripts

Authotkey description

Some of my AutoHotKey scripts, since people keep asking. I removed some personal scripts, like a hotstring that prints my address. Then I added comments to *everything* so that you can understand what's going on.

Disclaimer: most of these scripts are pretty jank. There's no incentives to clean things up when I'm the only developer *and* user. Your AHK should be the same way. Embrace the jank.

## How to use

Everything is called from `main`. If you're completely new to AHK, you can just copy everything from `main.ahk` before line TODO and then pick some of the hotstrings from `Hotstrings.ahk`. That's all you need to start making AHK useful!

Otherwise, feel free to download the entire thing, or scavenge just the parts that seem useful to you.

## General Design Notes

~~Almost all~~ *Many* of the hotkeys are designed to conflict minimally with the systems hotkeys. Some ways of achieving this: 

1. All hotstrings start with `;`, so that you don't accidentally type them
1. Hotkeys that use just ctrl or alt only activate with the *righthand* ctrl or alt. So if "rightctrl+1" is a hotkey, "leftctrl+1" will still do whatever it's supposed to.
1. Some hotkeys use win+alt, which I don't think anything else uses.
1. Some hotkeys are keyed to the numpad.

As this is adapted from my personal scripts, which I've steadily developed over time, not all hotkeys follow these rules.

### Learning Opportunities

Several of the files showcase different topics in AHK. Among them:

* Input hooks, extensible hotkeys: FolderMode
* Window Groups: WindowSwitcher
* Using external programs: Clipimage, Timer
* GUIs: TK
* Objects, writing to files: Researcher

Some of the files

**THIS IS V1, NOT V2.** I've migrated all my personal scripts to v2 (it's way better) but haven't updated this repo yet. Doing the work in another branch.