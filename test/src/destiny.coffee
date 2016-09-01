# Description
#   Test Game subclass based on Destiny
#
# Configuration:
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   Some of this will make it into production Destiny but right now it's just testing
#
# Author:
#   Shawn Sorichetti <ssoriche@gmail.com>
Game = require("../../src/GamerBot-Game.coffee")

class Destiny extends Game
  lfg: ->
    return true

  events: ->
    return {
      CoO:
        name: "Court of Oryx"
        maxplayers: 3
      CoE:
        name: "Challenge of Elders"
        maxplayers: 3
      KFHM:
        name: "King's Fall - Hard Mode"
        maxplayers: 6
    }

  name: ->
    return "Destiny"

  platforms: ->
    return ['PS4','XBONE']

module.exports = (robot) ->
  game = new Destiny robot, 'dtg'
