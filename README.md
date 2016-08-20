# GamerBot-Game

Base class for GamerBot Game modules

See [`src/gamerbot-game.coffee`](src/gamerbot-game.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install git+https://git@github.com/ssoriche/GamerBot-Game --save`

## Sample Implementation

```
Game = require("gamerbot-game")

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
```

## Included Commands

```
!{ident} - returns the name of the game
!{ident} platforms - list platforms game runs on
!{ident} events - list platforms game runs on
```
