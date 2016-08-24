# Description
#   Base class for GamerBot Game modules
#
# Configuration:
#
#    class Destiny extends Game
#      lfg: ->
#        return true
#
#      events: ->
#        return {
#          CoO:
#            name: "Court of Oryx"
#            maxplayers: 3
#          CoE:
#            name: "Challenge of Elders"
#            maxplayers: 3
#          KFHM:
#            name: "King's Fall - Hard Mode"
#            maxplayers: 6
#        }
#
#      name: ->
#        return "Destiny"
#
#      platforms: ->
#        return ['PS4','XBONE']
#
#    module.exports = (robot) ->
#      game = new Destiny robot, 'dtg'
#
# Commands:
#   !{ident} - returns the name of the game
#   !{ident} platforms - list platforms game runs on
#   !{ident} events - list platforms game runs on
#
# Notes:
# This is a base class and requires the attributes to be overriden to respond
# correctly to the game requests.
#
# Author:
#   Shawn Sorichetti <ssoriche@gmail.com>

class Game
  constructor: (@robot, @ident) ->
    @cache = {}

    @robot.hear ///^[\.!]#{@ident}$///i, (msg) =>
      msg.send @name()

    @robot.hear ///^[\.!]#{@ident}\s+lfg\?$///i, (msg) =>
      msg.send "LFG enabled: " + @lfg()

    @robot.hear ///^[\.!]#{@ident}\s+lfg$///i, (msg) =>

    @robot.hear ///^[\.!]#{@ident}\s+events$///i, (msg) =>
      events = ""
      for event in Object.keys(@events())
        events += "#{event} ... #{@events()[event].name}\n"
      if events.length > 0
        msg.send "Events:\n" + events

    @robot.hear ///^[\.!]#{@ident}\s+platform(s)?$///i, (msg) =>
      platforms = ""
      for platform in @platforms()
        platforms += "#{platform}\n"
      if platforms.length > 0
        msg.send "Platforms:\n" + platforms

    @robot.hear ///^[\.!]#{@ident}\s+(?:i\s+)?p(?:lays?)?$///i, (msg) =>
      nick = msg.message.user.name.toLowerCase()
      @add_player(nick)
      msg.send "#{nick} added as player of #{@name()}"

    @robot.hear ///^[\.!]#{@ident}\s+n(?:olonger)?\s+p(?:lays?)?$///i, (msg) =>
      nick = msg.message.user.name.toLowerCase()
      @rm_player(nick)
      msg.send "#{nick} is no longer a player of #{@name()}"

  lfg: ->
    return false

  events: ->
    return {}

  name: ->
    return ""

  platforms: ->
    return []

  add_player: (nick) =>
    players = @robot.brain.get "gamerbot.games.#{@ident}.players"
    players = players ? {}

    players[nick] = nick
    @robot.brain.set "gamerbot.games.#{@ident}.players", players

  rm_player: (nick) =>
    players = @robot.brain.get "gamerbot.games.#{@ident}.players"
    players = players ? {}

    delete players[nick]
    @robot.brain.set "gamerbot.games.#{@ident}.players", players

module.exports = Game
