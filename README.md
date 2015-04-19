# ta-macro

Simple macro recording and playback module for Textadept 7.9.

The module allows to record sequence of user actions and playback them one or more times.

## Install

To install this module `git clone` it in your `~/.textadept/modules` and add this

    local macro = require('ta-macro')
  
and something like this

    keys.cr = macro.record
    keys.cR = macro.finish
    keys.ar = macro.replay

to your `init.lua`.

See also this small article http://shitpoet.tk/adding-simple-macros-to-textadept-en.html
