#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# a small plugin to solve my gripe: http://forum.xchat.org/viewtopic.php?p=16027
# by Jason "zcat" Farrell; with thanks to "LifeIsPain" - 2008
__module_name__ = "reply-presence"
__module_description__ = "Notifies you if a user parts/quits before you've finished writing a reply to them. Also notifies you of their possible return, along with your partial reply text at the time they left. Very useful if you have disabled JOINS/PARTS or just don't notice people quitting on you in active channels."
__module_version__ = "0.2"
import xchat, re, time

quitters = {}   # { "username" : [ "partial reply", "#channel", timestamp ] }
def check_input(word, word_eol, userdata):
    #print xchat.get_context(), xchat.find_context()
    #if xchat.get_context() is xchat.find_context():
    nick = word[0]
    if userdata == "quitter":      # parts + reply to target in progress
        if xchat.get_context().get_info('channel') == xchat.find_context().get_info('channel') and re.search("(?i)^[^ ]*%s[,:] +" % re.escape(nick), xchat.get_info('inputbox')):
            quitters[nick] = [ xchat.get_info('inputbox'), xchat.get_info('channel'), time.time() ]
            print "▬" * 79
            print "▬▬▬ NOTE: %s has left before you've finished replying to them." % (nick)
            #print "▬▬▬ PARTIAL REPLY IS: %s" % (quitters[nick][0])
            print "▬" * 79
    elif userdata == "checkrejoin":  # check to see if quitters have rejoined
        if nick in quitters:
            print "▬" * 79
            print "▬▬▬ NOTE: %s has returned (to %s) %.1f minutes later." % (nick, quitters[nick][1], (time.time() - quitters[nick][2])/60)
            print "▬▬▬ PARTIAL REPLY WAS: %s" % (quitters[nick][0])
            print "▬" * 79
            del quitters[nick]

    return xchat.EAT_NONE


for e in ['Part', 'Part with Reason', 'Quit', 'Kick']:
    xchat.hook_print(e, check_input, "quitter")
xchat.hook_print('Join', check_input, "checkrejoin")
#xchat.hook_server('JOIN', check_input, "checkrejoin")
#[':maniac103!n=daba@50.250.80.212.static.versanetonline.de', 'JOIN', ':#fedora-devel'

print "%s %s loaded." % (__module_name__, __module_version__)

### example output:
#  reply-presence 0.1.2 loaded.
#  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
#  ▬▬▬ NOTE: randomjoe has left before you've finished replying to them.
#  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
# ...... time passes
#  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
#  ▬▬▬ NOTE: randomjoe has returned 0.3 minutes later.
#  ▬▬▬ PARTIAL REPLY WAS: randomjoe, don't leave before i finishing telling you about the
#  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
