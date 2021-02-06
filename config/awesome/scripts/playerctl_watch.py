#!/usr/bin/env python3


import gi

import time

gi.require_version('Playerctl', '2.0')

from gi.repository import Playerctl, GLib

# player = Playerctl.Player()

manager = Playerctl.PlayerManager()

# table for converting player status to output
status_lookup = {
    Playerctl.PlaybackStatus.PLAYING: 'p',
    Playerctl.PlaybackStatus.PAUSED:  'q',
    Playerctl.PlaybackStatus.STOPPED: 's'
}


def update(player):

    # just print a new up-to-date status string for awesome

    print(
        f'{status_lookup[player.props.playback_status]} {player.get_title()} | {player.get_artist()} | {player.get_album()} |',
        flush=True
    )
    # print(player.props.player_name, player.props.metadata)


def on_play(player, status):
    update(player)  

def on_pause(player, status):
    update(player)
    
def on_metadata(player, metadata):
    update(player)
    


def init_player(name):
    # connect every player to the manager    
    player = Playerctl.Player.new_from_name(name)
    player.connect('playback-status::playing', on_play)
    player.connect('playback-status::paused', on_pause)
    player.connect('metadata', on_metadata)
    manager.manage_player(player)


def on_name_appeared(manager, name):
    init_player(name)


# def on_player_vanished(manager, player):
#     print('player has exited: {}'.format(player.props.player_name))


manager.connect('name-appeared', on_name_appeared)
# manager.connect('player-vanished', on_player_vanished)

for name in manager.props.player_names:
    init_player(name)


if manager.props.players:
    update(manager.props.players[0])
else:
    print(status_lookup[Playerctl.PlaybackStatus.STOPPED], flush=True)


main = GLib.MainLoop()
main.run()

